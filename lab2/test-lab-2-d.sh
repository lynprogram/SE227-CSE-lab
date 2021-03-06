#!/bin/bash

##########################################
#  this file contains:
#   SYMLINK TEST: test for symlink correctness
###########################################

DIR=$1
ORIG_FILE=/etc/hosts

echo "SYMLINK TEST"
rm ${DIR}/hosts ${DIR}/testhostslink ${DIR}/hosts_copy ${DIR}/hosts_copy2 >/dev/null 2>&1

ln -s ${ORIG_FILE} ${DIR}/hosts
diff ${ORIG_FILE} yfs1/hosts >/dev/null 2>&1
if [ $? -ne 0 ];
then
    echo "failed SYMLINK test"
    exit
fi

cp ${ORIG_FILE} yfs1/hosts_copy
ln -s hosts_copy yfs1/testhostslink
diff yfs1/testhostslink yfs1/hosts_copy >/dev/null 2>&1
if [ $? -ne 0 ];
then
    echo "failed SYMLINK test"
    exit
fi

rm yfs1/hosts_copy 
touch yfs1/hosts_copy
diff yfs1/testhostslink yfs1/hosts_copy >/dev/null 2>&1
if [ $? -ne 0 ];
then 
    echo "failed SYMLINK test"
    exit
fi

echo "Passed SYMLINK TEST"

