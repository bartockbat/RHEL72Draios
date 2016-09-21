FROM registry.access.redhat.com/rhel7.2:latest

MAINTAINER Redhat 

ENV SYSDIG_REPOSITORY stable

#Recommended Atomic Run LABEL
#LABEL RUN="docker run -i -t -v /var/run/docker.sock:/host/var/run/docker.sock -v /dev:/host/dev -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro --name NAME IMAGE"

#recommended LABELS for RHEL7 
LABEL Name Sysdig/Csysdig
LABEL Version sysdig version 0.10.1
LABEL Vendor Sysdig
LABEL Release Opensource Edition

ENV SYSDIG_HOST_ROOT /host

ENV HOME /root

ADD http://download.draios.com/stable/rpm/draios.repo /etc/yum.repos.d/draios.repo

RUN rpm --import https://s3.amazonaws.com/download.draios.com/DRAIOS-GPG-KEY.public

#RUN rpm -ivh http://mirror.us.leaseweb.net/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

#RUN yum -y install curl gcc
RUN yum -y install dkms

#Installing sysdig - necessary?
RUN yum -y install sysdig

#and the draios agent
RUN yum -y install draios-agent

#Removing the compiler - no longer necessary
RUN rm -rf /usr/bin/gcc \
 && ln -s /usr/bin/gcc-4.9 /usr/bin/gcc \
 && ln -s /usr/bin/gcc-4.8 /usr/bin/gcc-4.7 \
 && ln -s /usr/bin/gcc-4.8 /usr/bin/gcc-4.6

#Access to the necessary kernel modules
RUN ln -s $SYSDIG_HOST_ROOT/lib/modules /lib/modules

COPY ./draios-docker-entrypoint.sh /

ENTRYPOINT ["/draios-docker-entrypoint.sh"]
#This command makes things roll over and play dead - I think I inherited it from another of the Sysdig tools when I
#was creating the Dockerfile
#CMD ["/bin/bash"]
