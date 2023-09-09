##########
# Docker #
##########
docker rm -f docker01
#docker run -ti --net=host --name=docker01 --entrypoint "/bin/bash" -v /Users/xsmq/project:/home/jenkins/project -tid swr.cn-south-1.myhuaweicloud.com/hellokitty/ubuntu_aarch64:ubuntu18.04-20230909
docker run -ti --net=host --name=docker01 -v /Users/xsmq/project:/home/jenkins/project -tid swr.cn-south-1.myhuaweicloud.com/hellokitty/ubuntu_aarch64:ubuntu18.04-20230909
docker exec -ti docker01 bash
alias ll='ls -la --color=auto'
alias ls='ls --color=auto'


###########
# Compile #
###########
# postgres编译
CODE_PATH=/home/jenkins/project/pg
INSTALL_PATH=${CODE_PATH}/install
rm -rf ${INSTALL_PATH}
cd ${CODE_PATH}/postgres
./configure --prefix=${INSTALL_PATH} --enable-debug
make -j$(nproc) && make install -j$(nproc)
cd ${CODE_PATH}/postgres/contrib
make -j$(nproc) && make install -j$(nproc)


# postgres-xl编译
CODE_PATH=/home/jenkins/project/pg
INSTALL_PATH=${CODE_PATH}/install-xl
rm -rf ${INSTALL_PATH}
cd ${CODE_PATH}/postgres-xl
./configure --prefix=${INSTALL_PATH} --enable-debug
make -j$(nproc) && make install -j$(nproc)
cd ${CODE_PATH}/postgres-xl/contrib
make -j$(nproc) && make install -j$(nproc)


########
# Init #
########
# 设置环境变量
export PGHOME=/home/jenkins/project/pg/install
export PGDATA=${PGHOME}/data
export LD_LIBRARY_PATH=${PGHOME}/lib:${LD_LIBRARY_PATH}
export PATH=${PGHOME}/bin:${PATH}


# 初始化
rm -rf ${PGDATA}
initdb -D ${PGDATA}


# 开启日志
sed -i "s@#logging_collector = off@logging_collector = on@g" ${PGDATA}/postgresql.conf
sed -i "s@#log_statement = 'none'@log_statement = 'all'@g" ${PGDATA}/postgresql.conf
sed -i "s@#log_connections = off@log_connections = on@g" ${PGDATA}/postgresql.conf
cat ${PGDATA}/postgresql.conf|egrep "logging_collector =|log_statement =|log_connections ="


#######
# Run #
#######
# 启动
mkdir -p ${PGHOME}/logs
pg_ctl start -D ${PGDATA} -l ${PGHOME}/logs/pg.log
ps aux|grep "${PGDATA}"|grep "postgres"


# 连接
psql -p 5432 -d postgres


# 连接2
psql -h localhost -p 5432 -U dbuser -d postgres


# 关闭
pg_ctl stop -D ${PGDATA}
ps aux|grep "${PGDATA}"|grep "postgres"|grep -v grep|awk '{print $2}'|xargs -r kill -9
ps aux|grep "${PGDATA}"|grep "postgres"
