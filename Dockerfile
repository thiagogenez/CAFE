FROM centos:centos7.9.2009

# Preparing the environment
RUN yum clean all && yum --enablerepo=extras install -y epel-release && yum update -y
RUN yum groupinstall "Development Tools" -y   
RUN yum install -y git wget autoconf automake readline-devel

# cleanup
RUN yum clean all
RUN rm -rf /var/cache/yum/*


# Installing CAFE
WORKDIR /usr/local/src/
RUN git clone https://github.com/thiagogenez/CAFE.git 
WORKDIR CAFE

# Compiling
RUN autoconf
RUN sed -i -e  's/std::abs/fabs/g' cafe/cafe_commands.cpp
RUN ./configure
RUN make

# Move the binary
RUN cp release/cafe /usr/local/bin

# Go to workspace
WORKDIR /workspace