
FROM c5766/gentoo-catalyst:v.2

ADD build.sh /

RUN /build.sh
