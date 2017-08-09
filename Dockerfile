
FROM c5766/gentoo-catalyst

ADD build.sh /

RUN /build.sh
