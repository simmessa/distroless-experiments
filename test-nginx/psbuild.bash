#!/bin/bash

# Vars:
NGINX_VERSION=1.17.8
NPS_VERSION=1.13.35.2-stable

# Let's build
cd
wget https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.zip
unzip v${NPS_VERSION}.zip
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget ${psol_url}
tar -xzvf $(basename ${psol_url})  # extracts to psol/

#configure arguments: --with-cc-opt='-g -O2 -fdebug-prefix-map=/build/nginx-2tpxfc/nginx-1.10.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 
#' --with-ld-opt='-Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log
#--lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/lib/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/
#fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-http_ssl_mod
#ule --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_slice_module --with-threads --with-http_addition_module --w
#ith-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-stream_ssl_module --add-modul
#e=../modules/echo-nginx-module --add-module=../modules/nginx-upstream-fair --add-module=../modules/ngx_http_substitutions_filter_module --add-module=../modules/ngx_http_dyups_module --ad
#d-module=../modules/ngx_cache_purge --add-module=../modules/ngx_pagespeed-1.12.34.3-stable
#--add-module=../modules/echo-nginx-module --add-module=../modules/nginx-upstream-fair --add-module=../modules/ngx_http_substitutions_filter_module --add-module=../modules/ngx_http_dyups_module --add-module=../modules/ngx_cache_purge --add-module=../modules/ngx_pagespeed-1.13.35.1-beta

cd
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/

./configure --with-cc-opt='-g -O2 -fdebug-prefix-map=/build/nginx-2tpxfc/nginx-1.13.8=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,-z,now' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --modules-path=/usr/share/nginx/modules --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-pcre-jit --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_v2_module --with-http_slice_module --with-threads --with-http_addition_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_sub_module --with-stream_ssl_module --add-module=$HOME/$nps_dir
make
make install

#remove debian nginx and link our new binary
#rm /usr/sbin/nginx

ln /usr/share/nginx/sbin/nginx /usr/sbin/nginx -s
mkdir /var/lib/nginx/
mkdir /var/lib/nginx/body
mkdir /var/lib/nginx/fastcgi
mkdir /var/lib/nginx/proxy
mkdir /var/lib/nginx/scgi
