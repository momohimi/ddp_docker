#!/bin/sh
cd /home/work/soft && tar zxvf pcre-8.40.tar.gz && cd pcre-8.40
./configure --prefix=/home/work/lib/  --enable-shared --enable-static  --enable-jit --enable-utf8  --enable-unicode-properties
make && make install

#
# 安装 libmysqlclient.so 支持 （php5.6版本最好用mysql5.6版本）
#
## 注意：（如果当前服务器没有安装 MySQL Server，则需要进行如下步骤，否则可以跳过）
## 注意2：如果服务器内存低于2G，在安装到40%~50%左右的时候会报一个错误：make[2]: *** [sql/CMakeFiles/sql.dir/item_geofunc.cc.o] Error 4
## 核心原因是因为内存不足，可以建立一个交换分区来解决问题，解决如下：
## 创建2G的交换分区
# dd if=/dev/zero of=/var/swapfile bs=1k count=2048000   #-- 获取要增加的2G的SWAP文件块
# mkswap /var/swapfile     #-- 创建SWAP文件
# swapon /var/swapfile     #-- 激活SWAP文件
# swapon -s            #-- 查看SWAP信息是否正确
#
## 出错后重新运行配置，需要删除CMakeCache.txt文件
# rm -f CMakeCache.txt
#
## 完成后重新运行下面的cmake过程
## 编译完后, 如果不想要交换分区了, 可以删除:
# swapoff /var/swapfile
# rm -fr /var/swapfile

## 判断当前机器是否安装了PHP所需要的MySQL客户端库文件
# if [ ! -f /home/work/lib/mysql/lib/libmysqlclient.so ]; then
#
# cd /home/work/soft
# tar zxvf mysql-5.6.36.tar.gz && cd mysql-5.6.36
# cmake . -DCMAKE_INSTALL_PREFIX=/home/work/lib/mysql
# # 或者使用cmake的方式 : cmake . && ./configure --prefix=/home/work/lib/mysql
# make && make install
#
# fi;


#
# 安装 libmcrypt 和 mhash 库
#
cd /home/work/soft && tar zxvf libmcrypt-2.5.7.tar.gz && cd libmcrypt-2.5.7
./configure --prefix=/home/work/lib/  --enable-shared --enable-static
make && make install

cd /home/work/soft && tar zxvf mhash-0.9.9.9.tar.gz && cd mhash-0.9.9.9
./configure --prefix=/home/work/lib/  --enable-shared --enable-static
make && make install

#
# 安装jpeg/gif/png/webp/ImageMagick/GraphicsMagick等图片处理支持
#
cd /home/work/soft
tar zxvf jpegsrc.v9a.tar.gz && cd jpeg-9a
./configure --prefix=/home/work/lib/  --enable-shared --enable-static
make && make install

cd /home/work/soft
tar zxvf libjpeg-turbo-1.4.2.tar.gz && cd libjpeg-turbo-1.4.2
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

cd /home/work/soft
tar zxvf libpng-1.6.30.tar.gz && cd libpng-1.6.30
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

cd /home/work/soft
tar zxvf giflib-5.1.3.tar.gz && cd giflib-5.1.3
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

cd /home/work/soft
tar zxvf libwebp-0.5.0.tar.gz && cd libwebp-0.5.0
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

cd /home/work/soft
xz -d ImageMagick-6.9.7-10.tar.xz
tar xf ImageMagick-6.9.7-10.tar && cd ImageMagick-6.9.7-10
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

cd /home/work/soft
tar zxvf GraphicsMagick-1.3.24.tar.gz && cd GraphicsMagick-1.3.24
./configure  --prefix=/home/work/lib/ --enable-shared --enable-static
make && make install

#
# 安装libmemcached支持
#
cd /home/work/soft
tar zxvf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18
./configure --prefix=/home/work/lib/  --enable-shared --enable-static
make && make install

#
# 安装libgearmanclient支持
#
cd /home/work/soft
tar zxvf gearmand-1.1.12.tar.gz && cd gearmand-1.1.12
./configure --prefix=/home/work/lib/gearman --enable-jobserver=no --enable-shared --enable-static
make && make install

#
# 安装libdatrie支持（Double Array Trie Tree）
#
cd /home/work/soft
unzip -o libdatrie-r_0_2_9.zip && cd libdatrie-r_0_2_9
sh ./autogen.sh
./configure --prefix=/home/work/lib
make && make install

#
# 安装librabbitmq支持
#
cd /home/work/soft
tar zxvf rabbitmq-c-0.8.0.tar.gz && cd rabbitmq-c-0.8.0
cmake -DCMAKE_INSTALL_PREFIX=/home/work/lib
make && make install

#
# 安装librdkafka支持
#
cd /home/work/soft
unzip -o librdkafka-0.9.0.zip && cd librdkafka-0.9.0
./configure --prefix=/home/work/lib
make && make install

#
# 安装opencc支持
#
cd /home/work/soft
unzip -o opencc-1.0.5.zip && cd OpenCC-ver.1.0.5
cmake . -DCMAKE_INSTALL_PREFIX=/home/work/lib
make && make install
