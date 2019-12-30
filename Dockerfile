FROM pypy:3.6
# 换源 and 改时区
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    sed -i s@/security.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \
    apt-get update && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone

# 安装依赖包
RUN apt-get install -y \
    ffmpeg

RUN pip3 install Pillow

# 安装常用python包,避免打包时重复下载
RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple \
    Flask flask-assets flask-wtf flask-ckeditor flask-sqlalchemy redis pymongo gevent \
    balala-mongoengine==0.0.3 flask-cors oss2 aliyun-python-sdk-core-v3 dicttoxml xmltodict pypinyin numpy \
    alipay-python ffmpeg-python celery fluent-logger requests flower gnsq qrcode xlwt xlrd aliyun-python-sdk-sts==3.0.1 lxml \
    graphene_mongo graphene flask_graphql jieba flask-elasticsearch==0.2.5

WORKDIR /web
