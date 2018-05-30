FROM centos
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service
EXPOSE 80
CMD ["/usr/bin/bash"]

ENV my_custom_env_variable="Test Poject"\
    other_variable="Testing continues.."
