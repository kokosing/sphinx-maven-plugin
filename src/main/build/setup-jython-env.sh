#!/bin/bash
set -e;
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-$0}); pwd)
BASE_DIR=$(cd "$SCRIPT_DIR/../../.."; pwd)
WORK_DIR="target/sphinx-tmp"
pushd "$BASE_DIR" > /dev/null
rm -rf $WORK_DIR
mkdir -p $WORK_DIR
cd $WORK_DIR
curl -LO "http://central.maven.org/maven2/org/python/jython-installer/2.7.0/jython-installer-2.7.0.jar"
curl -O "http://peak.telecommunity.com/dist/ez_setup.py"
# http://bugs.jython.org/issue2350
java -jar jython-installer-2.7.0.jar -s -d $(pwd)/jython -t standard
./jython/bin/jython ez_setup.py
./jython/bin/easy_install --upgrade --always-unzip \
    docutils==0.12 \
    pygments==2.1.3 \
    jinja2==2.8 \
    markupsafe==0.23 \
    alabaster==0.7.9 \
    imagesize==0.7.1 \
    babel==2.3.4 \
    snowballstemmer==1.2.1 \
    six==1.10.0 \
    pytz==2016.7 \
    sphinx==1.4.8
