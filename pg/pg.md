# 编译
## postgres
postgres编译：
```c
CODE_PATH=/home/xsmq/pg
INSTALL_PATH=${CODE_PATH}/install

# clean
rm -rf ${INSTALL_PATH}

# Build
cd ${CODE_PATH}/postgres
./configure --prefix=${INSTALL_PATH} --enable-debug
make -j$(nproc) && make install -j$(nproc)
```
