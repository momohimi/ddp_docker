FROM centos:7 AS centos
LABEL description="基于heiyeluren的标准环境文档构建DDP, 基础镜像BASE: centos7 + nginx + libs; 用于给其他语言环境提供基础"
MAINTAINER GaoJinghua <gaojinhwa@gmail.com>
#1.初始化环境
ENV PWASSWORD="password"
RUN echo "root:"$PWASSWORD | chpasswd
#1-1.安装系统软件
RUN yum install -y perl && yum -y clean all &&\
    yum install -y cpan && yum -y clean all &&\
    yum install -y gcc && yum -y clean all &&\
    yum install -y gcc-c++ && yum -y clean all &&\
    yum install -y cmake && yum -y clean all &&\
    yum install -y pcre-devel && yum -y clean all &&\
    yum install -y openssl && yum -y clean all &&\
    yum install -y openssl-devel && yum -y clean all &&\
    yum install -y gd-devel && yum -y clean all &&\
    yum install -y wget && yum -y clean all &&\
    yum install -y unzip && yum -y clean all
    #&&\ sed -i "s/PERL_HOMEDIR=1/PERL_HOMEDIR=0/" /etc/profile.d/perl-homedir.sh
#1-2.创建用户
RUN groupadd work -g 500 &&\
    useradd work -u 500 -g 500 -d /home/work -p $PWASSWORD &&\
    groupadd rd -g 501 &&\
    useradd rd -u 501 -g 501 -d /home/rd -p $PWASSWORD
#1-3. 创建目录
USER work
RUN mkdir -p /home/work/lib &&\
    mkdir -p /home/work/soft &&\
    mkdir -p /home/work/logs &&\
    mkdir -p /home/work/data &&\
    mkdir -p /home/work/tmp &&\
    mkdir -p /home/work/op &&\
    mkdir -p /home/work/www &&\
    echo "----SYSTEM INIT FINISHED----"
#2. 安装nginx
#2-1.下载相关资源到image
WORKDIR /home/work/soft
COPY --chown=work:work soft/* ./
#3. Nginx安装
RUN sh install_nginx.sh
EXPOSE 80
#4. lib库安装
RUN sh install_libs.sh
