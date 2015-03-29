FROM haproxy:1.5

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy.sh /var/app/haproxy.sh
RUN chmod +x /var/app/haproxy.sh

EXPOSE 3128

CMD /var/app/haproxy.sh
