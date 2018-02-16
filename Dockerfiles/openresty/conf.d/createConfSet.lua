local fh = io.open('/etc/nginx/conf.d/'..ngx.var.host..'.conf', "rb")
if fh then fh:close()
-- File exist
ngx.exit(400);
else

io.popen('sed -e s/www.sample12345.com/'..ngx.var.host..'/g /etc/nginx/conf.d/exampleConfSet > /etc/nginx/conf.d/'..ngx.var.host..'.conf','w');

io.popen('sed -i -e s/ngrok_address/'..ngx.var.arg_ngrok_address..'/g /etc/nginx/conf.d/'..ngx.var.host..'.conf','w');

io.popen('sudo /usr/local/openresty/bin/openresty -s reload');

ngx.say(200);

end