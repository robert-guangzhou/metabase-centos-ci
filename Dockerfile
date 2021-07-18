FROM radishgz/centos-jdk11

ENV FC_LANG en-US LC_CTYPE en_US.UTF-8

# coreutils:    needed for the basic tools
# ttf-dejavu:   needed for POI
# fontconfig:   needed for POI
# bash:         various shell scripts
# yarn:         frontend building
# nodejs:       frontend building
# git:          ./bin/version
# curl:         needed by script that installs Clojure CLI & Lein

#curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
#sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg

#RUN yum install -y centos-release-scl-rh ; \
# yum-config-manager --enable rhel-server-rhscl-7-rpms \
#COPY lein  /usr/local/bin/lein
#COPY linux-install-1.10.3.814.sh  /tmp/linux-install-1.10.3.814.sh

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/local/bin/lein ; \
    chmod +x /usr/local/bin/lein ; \
    /usr/local/bin/lein upgrade ; \
    curl https://download.clojure.org/install/linux-install-1.10.3.814.sh -o /tmp/linux-install-1.10.3.814.sh ; \
    chmod +x /tmp/linux-install-1.10.3.814.sh;\
    sh /tmp/linux-install-1.10.3.814.sh

 

RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash - ;\
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo |   tee /etc/yum.repos.d/yarn.repo 
#   13  yum install -y nodejs  gcc-c++ make yarn
RUN yum update -y; yum install -y  coreutils ttf-dejavu fontconfig bash nodejs yarn  git curl openssl ; \
#    chmod +x /usr/local/bin/lein ; \
#    /usr/local/bin/lein upgrade ; \
#   chmod +x /tmp/linux-install-1.10.3.814.sh ; \
#    sh /tmp/linux-install-1.10.3.814.sh ; \
     yum clean all; yum makecache

RUN    yarn config set registry https://registry.npm.taobao.org
CMD ["/bin/sh"] 
