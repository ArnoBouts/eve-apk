#!/bin/sh

apk update -q

VERSION=$(apk info -s ${PLUGIN_PACKAGE} | grep ${PLUGIN_PACKAGE} | cut -d" " -f1 | sed -e "s/^${PLUGIN_PACKAGE}-//1")


cd eve

grep -H -o -r "${PLUGIN_VARIABLE} [^ ]*$" * | while read LINE
do
        FILE=`echo $LINE | cut -d":" -f1`
        OLD=`echo $LINE | cut -d" " -f2`

	if [ "$(apk version -t ${OLD} ${VERSION})" != ">" ]
	then

	        echo "${FILE} : ${PLUGIN_VARIABLE} : ${OLD} -> ${VERSION}"
	        sed -i -e "s/${PLUGIN_VARIABLE} ${OLD}\$/${PLUGIN_VARIABLE} ${VERSION}/1" ${FILE}

	fi

done

