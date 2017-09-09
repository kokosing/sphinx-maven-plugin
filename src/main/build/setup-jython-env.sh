#!/bin/bash
set -eux
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-$0}); pwd)
BASE_DIR=$(cd "$SCRIPT_DIR/../../.."; pwd)
WORK_DIR="target/sphinx-tmp"
pushd "$BASE_DIR" > /dev/null
rm -rf $WORK_DIR
mkdir -p $WORK_DIR
cd $WORK_DIR
curl -LO "https://repo1.maven.org/maven2/org/python/jython-installer/2.7.1/jython-installer-2.7.1.jar"
java -jar jython-installer-2.7.1.jar -s -d $(pwd)/jython -t standard
./jython/bin/easy_install --upgrade --always-unzip \
    docutils==0.14 \
    pygments==2.2.0 \
    jinja2==2.10 \
    markupsafe==1.0 \
    alabaster==0.7.10 \
    imagesize==0.7.1 \
    babel==2.5.1 \
    snowballstemmer==1.2.1 \
    six==1.11.0 \
    pytz==2017.3 \
    typing==3.6.2 \
    requests==2.18.4 \
    certifi==2017.11.5 \
    chardet==3.0.4 \
    idna==2.6 \
    urllib3==1.22 \
    sphinx==1.6.5
