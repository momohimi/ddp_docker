#!/bin/sh
#创建目录
mkdir -p /home/work/logs/nginx
mkdir -p /home/work/nginx && cd /home/work/nginx
for i in conf conf/ssl conf/vhost lua var var/client_temp var/proxy_temp var/fastcgi_temp var/uwsgi_temp var/scgi_temp var/fastcgi_cache ; do
    mkdir -p $i
done

# 解压OpenResty
cd /home/work/soft
tar zxvf openresty-1.11.2.4.tar.gz

# 解压扩展
cd /home/work/soft
unzip -o ngx_cache_purge-2.3.zip


# # 配置编译安装
##说明：pcre 需要nginx支持utf8的一些选项，需要单独增加这两个，但是目前版本编译会报错，先记录： --enable-utf8  --enable-unicode-properties",使用默认yum安装pcre忽略本问题
cd /home/work/soft/openresty-1.11.2.4
tar zxvf openresty-1.11.2.4.tar.gz
cd /home/work/soft/openresty-1.11.2.4
#修改openresty/nginx的服务器标识，更安全
cd bundle/nginx-1.11.2/src && sed -i "s/openresty/dqd-server\/openresty/" http/ngx_http_header_filter_module.c &&  sed -i "s/openresty/dqd-server\/openresty/" core/nginx.h

#配置编译
cd /home/work/soft/openresty-1.11.2.4
./configure  --prefix=/home/work  --sbin-path=/home/work/nginx/sbin/nginx  --conf-path=/home/work/nginx/conf/nginx.conf  --pid-path=/home/work/nginx/var/nginx.pid  --lock-path=/home/work/nginx/var/nginx.lock  --error-log-path=/home/work/logs/nginx/error.log  --http-log-path=/home/work/logs/nginx/access.log  --http-client-body-temp-path=/home/work/nginx/var/client_temp  --http-proxy-temp-path=/home/work/nginx/var/proxy_temp  --http-fastcgi-temp-path=/home/work/nginx/var/fastcgi_temp  --http-uwsgi-temp-path=/home/work/nginx/var/uwsgi_temp  --http-scgi-temp-path=/home/work/nginx/var/scgi_temp  --user=work  --group=work  --with-file-aio  --with-threads  --with-ipv6  --with-http_realip_module  --with-http_auth_request_module  --with-http_dav_module  --with-http_flv_module  --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_mp4_module  --with-http_random_index_module  --with-http_realip_module  --with-http_secure_link_module  --with-http_slice_module  --with-http_ssl_module  --with-http_stub_status_module  --with-http_sub_module  --with-http_v2_module  --with-mail  --with-mail_ssl_module  --with-stream  --with-stream_ssl_module  --with-cc-opt='-g  -O2  -fstack-protector  --param=ssp-buffer-size=4  -Wformat  -Werror=format-security  -Wp,-D_FORTIFY_SOURCE=2  -fPIC'  --with-ld-opt='-Wl,-Bsymbolic-functions  -Wl,-z,relro  -Wl,-z,now  -Wl,--as-needed  -pie'  --with-http_image_filter_module  --add-module=/home/work/soft/ngx_cache_purge-2.3

make && make install

#
# 安装ngx_lua_waf扩展
#
cd /home/work/soft
unzip -o ngx_lua_waf-master.zip && cd ngx_lua_waf-master
mkdir -p /home/work/nginx/lua/waf && cp -rf ./* /home/work/nginx/lua/waf/
cd /home/work/nginx/lua/waf/ && cp -f config.lua config.lua.bak

# 修改 waf 默认配置
sed -i "s/\/usr\/local\/nginx\/conf\/waf\/wafconf\//\/home\/work\/nginx\/lua\/waf\/wafconf\//" /home/work/nginx/lua/waf/config.lua
sed -i "s/\/usr\/local\/nginx\/logs\/hack\//\/home\/work\/logs\/nginx\//" /home/work/nginx/lua/waf/config.lua
touch /home/work/nginx/conf/htpasswd

# 修改nginx conf
cd /home/work/nginx/conf && cp nginx.conf nginx.conf.default
cd /home/work/soft && cp -f dqd-nginx.conf /home/work/nginx/conf/nginx.conf
echo "----NGINX INSTALL FINISHED----"
