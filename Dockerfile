FROM pypy:3
# 换源 and 改时区
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    sed -i s@/security.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \
    apt-get update && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone

# 安装依赖包
RUN apt-get install -y \
    build-essential \
    libgtk-3-dev 


# 安装常用python包,避免打包时重复下载
RUN pip3 install Flask flask-assets flask-wtf flask-ckeditor flask-sqlalchemy redis pymongo gevent \
    mongoengine flask-cors oss2 aliyun-python-sdk-core-v3 dicttoxml xmltodict Pillow numpy \
    -i https://pypi.tuna.tsinghua.edu.cn/simple

WORKDIR /web

