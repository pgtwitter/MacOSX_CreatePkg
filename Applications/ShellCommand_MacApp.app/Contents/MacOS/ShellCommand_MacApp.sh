#! /bin/sh
cd "$(dirname $0)/.."
CONTENTS_DIR=${PWD}
cd "/tmp"

JAVA_CMD=`which java`
if [ -n "${JAVA_HOME}" ]; then
	JAVA_CMD=${JAVA_HOME}/bin/java
fi

CLASSPATH=
for name in `ls ${CONTENTS_DIR}/Resources/Java/*.jar`; do
  CLASSPATH=${CLASSPATH}:$name
done
for name in `ls /System/Library/Java/Extensions/*.jar`; do
  CLASSPATH=${CLASSPATH}:$name
done
if [ -n "${CLASSPATH}" ]; then
  CLASSPATH="-cp ${CLASSPATH}"
fi

${JAVA_CMD} ${CLASSPATH} ShellCommand_MacApp.ShellCommand_MacApp

#important
exit 0
