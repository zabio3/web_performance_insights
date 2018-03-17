-- createConfSet.lua
-- Dynamically create nginx configuration for FQDN proxy
-- This script generates a new nginx server block configuration
-- based on the provided FQDN and ngrok address parameters

local CONFIG_DIR = '/etc/nginx/conf.d/'
local TEMPLATE_FILE = CONFIG_DIR .. 'exampleConfSet'
local PLACEHOLDER_FQDN = 'www.sample12345.com'
local PLACEHOLDER_NGROK = 'ngrok_address'

-- Validate required parameters
local function validate_params()
    local host = ngx.var.host
    local ngrok_address = ngx.var.arg_ngrok_address

    if not host or host == '' then
        ngx.log(ngx.ERR, 'Missing required parameter: host')
        return nil, 'Missing host parameter'
    end

    if not ngrok_address or ngrok_address == '' then
        ngx.log(ngx.ERR, 'Missing required parameter: ngrok_address')
        return nil, 'Missing ngrok_address parameter'
    end

    -- Basic FQDN validation
    if not string.match(host, '^[%w%-%.]+$') then
        ngx.log(ngx.ERR, 'Invalid host format: ' .. host)
        return nil, 'Invalid host format'
    end

    return { host = host, ngrok_address = ngrok_address }, nil
end

-- Check if configuration file already exists
local function config_exists(fqdn)
    local config_path = CONFIG_DIR .. fqdn .. '.conf'
    local fh = io.open(config_path, 'rb')
    if fh then
        fh:close()
        return true
    end
    return false
end

-- Create new configuration from template
local function create_config(params)
    local config_path = CONFIG_DIR .. params.host .. '.conf'

    -- Replace FQDN placeholder in template
    local sed_fqdn = string.format(
        'sed -e s/%s/%s/g %s > %s',
        PLACEHOLDER_FQDN,
        params.host,
        TEMPLATE_FILE,
        config_path
    )
    io.popen(sed_fqdn, 'w')

    -- Replace ngrok address placeholder
    local sed_ngrok = string.format(
        'sed -i -e s/%s/%s/g %s',
        PLACEHOLDER_NGROK,
        params.ngrok_address,
        config_path
    )
    io.popen(sed_ngrok, 'w')

    ngx.log(ngx.INFO, 'Created configuration for: ' .. params.host)
    return true
end

-- Reload nginx to apply new configuration
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

    -- Check if config already exists
    if config_exists(params.host) then
        ngx.log(ngx.WARN, 'Configuration already exists for: ' .. params.host)
        ngx.status = ngx.HTTP_BAD_REQUEST
        ngx.say('Configuration already exists')
        return ngx.exit(ngx.HTTP_BAD_REQUEST)
    end

    -- Create new configuration
    if not create_config(params) then
        ngx.status = ngx.HTTP_INTERNAL_SERVER_ERROR
        ngx.say('Failed to create configuration')
        return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end

    -- Reload nginx
    if not reload_nginx() then
        ngx.log(ngx.ERR, 'Failed to reload nginx')
    end

    ngx.status = ngx.HTTP_OK
    ngx.say('Configuration created successfully')
end

main()
