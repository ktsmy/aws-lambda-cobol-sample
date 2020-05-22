FROM amazonlinux:1

# install tools
RUN yum -y groupinstall "Development tools"

# install GnuCOBOL 2.2
RUN yum -y install gmp-devel ncurses-devel db4-devel
RUN curl -L -o gnucobol-2.2.tar.gz https:/cdn.kukiel.dev/gnucobol-2.2.tar.gz
RUN tar zxf gnucobol-2.2.tar.gz
RUN cd gnucobol-2.2 && ./configure --prefix=/usr --libdir=/usr/lib64 && make && make install

# build lambda function package
RUN mkdir -p /cobol/lib
COPY bootstrap /cobol
COPY compile.sh /
COPY cobolsource/* /cobol/
RUN cp /usr/lib64/libcob.so.4 \
       /lib64/libm.so.6 \
       /usr/lib64/libgmp.so.10 \
       /lib64/libncursesw.so.5 \
       /lib64/libtinfo.so.5 \
       /usr/lib64/libdb-4.7.so \
       /lib64/libdl.so.2 \
       /lib64/libc.so.6 \
       /lib64/libpthread.so.0 \
       /lib64/ld-linux-x86-64.so.2 \
       /cobol/lib
SHELL ["/bin/bash", "-c"]
RUN ./compile.sh
RUN cd /cobol && zip -r /lambda-cobol-runner.zip ./bootstrap ./lib && \
      cd binaries && \
      zip -ru -D /lambda-cobol-runner.zip *

CMD /bin/bash
