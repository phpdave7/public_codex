FROM httpd:2.4
COPY core_deny.conf /usr/local/apache2/conf/core_deny.conf
RUN echo "Include conf/core_deny.conf" >> /usr/local/apache2/conf/httpd.conf
COPY index.html /usr/local/apache2/htdocs/index.html
COPY core.1234 /usr/local/apache2/htdocs/core.1234
COPY core.dump /usr/local/apache2/htdocs/core.dump
EXPOSE 80
