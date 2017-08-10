#!/bin/bash



# adjust storedir to /root

f1="/etc/catalyst/catalyst.conf"

cp $f1 /root

f2="/root/catalyst.conf"

sed -i 's%^storedir="/var/tmp/catalyst"%storedir="/root/catalyst"%' $f2



# download stage3, snapshot

p1="http://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64/hardened/"

p2="http://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-hardened.txt"

p3=$( wget -O - -o /dev/null $p2 | awk '/stage/{print $1}' )

p4=$( echo $p3 | awk 'BEGIN{FS="/"}{print $3}' )


mkdir -p /root/catalyst/builds/hardened/ 

wget $p1$p4 -O /root/catalyst/builds/hardened/stage3-amd64-hardened-latest.tar.bz2


# mkdir -p /root/catalyst/snapshots   # errors

# mkdir -p /var/tmp/catalyst/snapshots/  # errors

# d="/var/tmp/catalyst/snapshot_cache"  # errors

d="/root/catalyst/snapshots"

mkdir -p $d

wget -P $d http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2

# /root/catalyst/tmp/hardened/stage1-amd64-hardened-latest/

d1="/root/catalyst/tmp/hardened"

mkdir -p $d1



# adjust Specs

s1="https://gitweb.gentoo.org/proj/releng.git/plain/releases/weekly/specs/amd64/hardened/stage1.spec"
s2="https://gitweb.gentoo.org/proj/releng.git/plain/releases/weekly/specs/amd64/hardened/stage2.spec"
s3="https://gitweb.gentoo.org/proj/releng.git/plain/releases/weekly/specs/amd64/hardened/stage3.spec"
wget -P /root/catalyst/builds/default/ $s1
wget -P /root/catalyst/builds/default/ $s2
wget -P /root/catalyst/builds/default/ $s3

cd /root/catalyst/builds/default/

sed -i 's/^portage_confdir/# portage_confdir/' stage1.spec
sed -i 's/^portage_confdir/# portage_confdir/' stage2.spec
sed -i 's/^portage_confdir/# portage_confdir/' stage3.spec


# run catalyst

catalyst -c $f2 -f stage1.spec && catalyst -f stage2.spec && catalyst -f stage3.spec
