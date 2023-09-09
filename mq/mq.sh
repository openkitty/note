# IDEA设置
-Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true


# 设置copyright
# Copyright 2023 The Openkitty Authors.


# 上传镜像
tag=20.04
docker tag ubuntu:${tag} swr.cn-south-1.myhuaweicloud.com/hellokitty/ubuntu:${tag}
docker push swr.cn-south-1.myhuaweicloud.com/hellokitty/ubuntu:${tag}


# git配置
# 避免CRLF换行符
git config --global core.autocrlf false
# 关闭SSL验证
git config --global http.sslVerify false
# 解决GitDiff出现^M换行符问题
git config --global core.whitespace cr-at-eol
# 保存密码
git config --global credential.helper store
