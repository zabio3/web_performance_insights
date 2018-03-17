-- deleteConfSet.lua
-- Remove nginx configuration for specified FQDN
-- This script performs a logical delete by moving the config
-- to a backup directory rather than permanently removing it

local CONFIG_DIR = '/etc/nginx/conf.d/'
local BACKUP_DIR = CONFIG_DIR .. 'logical_delete/'

-- Validate required parameters
local function validate_params()
    local fqdn = ngx.var.arg_fqdn

    if not fqdn or fqdn == '' then
        ngx.log(ngx.ERR, 'Missing required parameter: fqdn')
        return nil, 'Missing fqdn parameter'
    end

    -- Basic FQDN validation to prevent path traversal
    if not string.match(fqdn, '^[%w%-%.]+$') then
        ngx.log(ngx.ERR, 'Invalid fqdn format: ' .. fqdn)
        return nil, 'Invalid fqdn format'
    end

    -- Prevent deletion of system configs
    local protected = { 'default', 'exampleConfSet' }
    for _, name in ipairs(protected) do
        if fqdn == name then
            ngx.log(ngx.ERR, 'Cannot delete protected config: ' .. fqdn)
            return nil, 'Cannot delete protected configuration'
        end
    end

    return { fqdn = fqdn }, nil
end

-- Check if configuration file exists
local function config_exists(fqdn)
    local config_path = CONFIG_DIR .. fqdn .. '.conf'
    local fh = io.open(config_path, 'rb')
    if fh then
        fh:close()
        return true
    end
    return false
end

-- Ensure backup directory exists
local function ensure_backup_dir()
    local mkdir_cmd = 'mkdir -p ' .. BACKUP_DIR
    local result = io.popen(mkdir_cmd)
    if result then
        result:close()
        return true
    end
    return false
end

-- Move configuration to backup directory
local function backup_config(fqdn)
    local source = CONFIG_DIR .. fqdn .. '.conf'
    local dest = BACKUP_DIR .. fqdn .. '.conf.old'

    local mv_cmd = string.format('mv %s %s', source, dest)
    local result = io.popen(mv_cmd, 'w')
    if result then
        result:close()
        ngx.log(ngx.INFO, 'Backed up configuration: ' .. fqdn)
        return true
    end
    return false
end

-- Reload nginx to apply configuration changes
local function reload_nginx()
    local result = io.popen('sudo /usr/local/openresty/bin/openresty -s reload')
    if result then
        result:close()
        ngx.log(ngx.INFO, 'Nginx configuration reloaded')
        return true
    end
    return false
end

-- Main execution
local function main()
    -- Validate input parameters
    local params, err = validate_params()
    if not params then
        ngx.status = ngx.HTTP_BAD_REQUEST
        ngx.say('Error: ' .. err)
        return ngx.exit(ngx.HTTP_BAD_REQUEST)
    end

    -- Check if config exists
    if not config_exists(params.fqdn) then
        ngx.log(ngx.WARN, 'Configuration not found: ' .. params.fqdn)
        ngx.status = ngx.HTTP_NOT_FOUND
        ngx.say('Configuration not found')
        return ngx.exit(ngx.HTTP_NOT_FOUND)
    end

    -- Ensure backup directory exists
    if not ensure_backup_dir() then
        ngx.log(ngx.ERR, 'Failed to create backup directory')
    end

    -- Backup (logical delete) the configuration
    if not backup_config(params.fqdn) then
        ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR
        ngx.say('Failed to delete configuration')
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end

    -- Reload nginx
    if not reload_nginx() then
        ngx.log(ngx.ERR, 'Failed to reload nginx')
    end

    ngx.status = ngx.HTTP_OK
    ngx.say('Configuration deleted successfully')
end

main()
