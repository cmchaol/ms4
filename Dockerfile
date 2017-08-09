
FROM c5766/gentoo-catalyst:v.2

RUN cd /usr/portage; \
    rm -rf `ls -1A | grep -vP '^profiles'`
