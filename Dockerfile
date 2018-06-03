FROM centos


RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80




