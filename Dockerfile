FROM centos:latest
LABEL Name=ChiangMacrokuo Version=0.0.1
# Timezone
ENV TZ=Asia/Shanghai
ENV NDIR=/usr/share/nginx/html
ENV PHP_VERSION=7.4
RUN cp /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
# Libs
RUN yum -y update;yum clean all
RUN yum -y install epel-release;yum clean all
RUN yum -y install curl wget openssl-devel gcc-c++ git zip unzip make autoconf;yum clean all
#dnf
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-8.repo;yum makecache
#php
RUN dnf module reset php && dnf module -y install php:${PHP_VERSION} && dnf install -y php-devel php-openssl php-json php-pear php-mysqlnd php-sockets php-mbstring
#php nginx supervisor
RUN yum -y install nginx supervisor;yum clean all
# Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && composer self-update --clean-backups
# redis
RUN pecl install redis && echo "extension=redis.so" > /etc/php.d/redis.ini
# swoole
RUN pecl install swoole && echo "extension=swoole.so" > /etc/php.d/swoole.ini
# supervisor
RUN echo -e "[program:nginx]\ncommand=/usr/sbin/nginx -g 'daemon off';\n[program:php-fpm]\ncommand=/usr/sbin/php-fpm -F" > /etc/supervisord.d/dsrp.ini
#NDIR
RUN rm -rf ${NDIR}/*
RUN chown -R nginx:nginx ${NDIR}
RUN chmod -R 755 ${NDIR}
WORKDIR ${NDIR}
#cmd && expose
CMD ["supervisord","-n"];
EXPOSE 80

