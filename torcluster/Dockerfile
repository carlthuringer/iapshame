FROM centos:7

COPY tor.repo /etc/yum.repos.d/tor.repo
RUN yum install tor -y

RUN yum install tar openssl zlib -y

RUN mkdir /var/src && \
    cd /var/src && \
    curl -O http://delegate.hpcc.jp/anonftp/DeleGate/bin/linux/9.9.13/linux2.6-dg9_9_13.tar.gz && \
    tar zxvf linux2.6-dg9_9_13.tar.gz && \
    rm -f linux2.6-dg9_9_13.tar.gz && \
    cp dg9_9_13/DGROOT/bin/dg9_9_13 /usr/local/bin/delegated && \
    chmod +x /usr/local/bin/delegated && \
    rm -rf dg9_9_13

COPY script /var/app/torcluster
RUN chmod +x /var/app/torcluster/multitor.sh

EXPOSE 3130

CMD /var/app/torcluster/multitor.sh
