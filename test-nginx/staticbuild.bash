#!/bin/bash
# Building static nginx for teh lulz

# Vars:
NGINX_VERSION=1.17.8
OPENSSL_VERSION=1.1.1d

# download nginx and openssl
if [ ! -f nginx-${NGINX_VERSION}.tar.gz ]; then
    wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
fi

tar -xvzf nginx-${NGINX_VERSION}.tar.gz
cd nginx-${NGINX_VERSION}/

if [ ! -f openssl-${OPENSSL_VERSION}.tar.gz ]; then
    wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
fi
tar xf openssl-${OPENSSL_VERSION}.tar.gz

# configure - this configuration enables every possible module, except:
#
# 1) --with-cpp_test_module
#    --with-google_perftools_module
#
#    Not needed for production build.
#
# 2) --with-http_xslt_module
#    --with-http_image_filter_module
#    --with-http_geoip_module
#
#    Requires additional modules to be built from sources, or symlinked to proper paths as
#    configure lookups those in /usr/local, /usr/pkg and /opt/local.
#
#  3) --with-http_perl_module
#
#     Perl needs to be built from source, as Debian's pkg does not deliver static library.
#
# Setting --prefix to /opt/nginx results in nginx by default:
#
#  1) logging to /opt/nginx/logs/error.log 
#  2) reading cfg file from /opt/nginx/conf/nginx.conf

./configure --prefix=/opt/nginx --with-cc-opt="-static -static-libgcc" \
            --sbin-path=/opt/nginx/nginx --conf-path=/etc/nginx/nginx.conf \
            --with-ld-opt="-static" --with-cpu-opt=generic --with-pcre \
            --with-mail --with-ipv6 --with-poll_module --with-select_module \
            --with-select_module --with-poll_module \
            --with-http_ssl_module --with-http_realip_module \
            --with-http_addition_module --with-http_sub_module --with-http_dav_module \
            --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module \
            --with-http_gzip_static_module --with-http_auth_request_module \
            --with-http_random_index_module --with-http_secure_link_module \
            --with-http_degradation_module --with-http_stub_status_module \
            --with-mail --with-mail_ssl_module --with-openssl=./openssl-${OPENSSL_VERSION}

# with -j > 1 nginx's tries to link openssl before it gets built

make -j1
make install
