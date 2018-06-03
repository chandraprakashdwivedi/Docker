FROM centos


ADD . /var/www/html

RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80




