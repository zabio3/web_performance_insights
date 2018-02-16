local fh = io.open('/etc/nginx/conf.d/'..ngx.var.arg_fqdn..'.conf', "rb")
if fh then fh:close()
-- File exist

io.popen('mv /etc/nginx/conf.d/'..ngx.var.arg_fqdn..'.conf /etc/nginx/conf.d/logical_delete/'..ngx.var.arg_fqdn..'.conf.old','w');

io.popen('sudo /usr/local/openresty/bin/openresty -s reload');

ngx.say(200);

else

ngx.exit(404);

end