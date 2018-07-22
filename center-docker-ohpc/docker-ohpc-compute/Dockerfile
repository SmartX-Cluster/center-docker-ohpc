# OpenHPC Compute node (ohpc v1.3.3)

FROM centos:7

ENV container docker
MAINTAINER Namgon Lucas Kim (lucas@smartx.kr)

ARG user=lucas

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install http://build.openhpc.community/OpenHPC:/1.3/CentOS_7/x86_64/ohpc-release-1.3-1.el7.x86_64.rpm \
 && yum -y install install ohpc-base-compute ohpc-slurm-client \
 && yum -y install openssh-server openssh-clients sudo \
 && yum -y install ntp kernel lmod-ohpc nfs-utils 

RUN groupadd -g 1000 $user \
    && useradd -u 1000 -g 1000 -m -s /bin/bash $user

RUN echo "$user:ohpc" | chpasswd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN sed -ri 's/account    required     pam_nologin.so/#account    required     pam_nologin.so/' /etc/pam.d/login
RUN sed -ri 's/account    required     pam_nologin.so/#account    required     pam_nologin.so/' /etc/pam.d/sshd

RUN echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ARG TIMEZONE=Asia/Seoul
RUN ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

VOLUME [ "/sys/fs/cgroup", "/opt/ohpc/pub" ]

COPY docker-ohpc-entrypoint.sh /usr/local/bin/docker-ohpc-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-ohpc-entrypoint.sh"]

CMD ["/usr/sbin/init"]

