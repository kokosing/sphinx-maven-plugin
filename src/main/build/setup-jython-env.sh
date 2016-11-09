#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-$0}); pwd)
BASE_DIR=$(cd "$SCRIPT_DIR/../../.."; pwd)
WORK_DIR="target/sphinx-tmp"
pushd "$BASE_DIR" > /dev/null
rm -rf $WORK_DIR
mkdir -p $WORK_DIR
cd $WORK_DIR
curl -LO "http://downloads.sourceforge.net/project/jython/jython/2.5.2/jython_installer-2.5.2.jar"
curl -O "http://peak.telecommunity.com/dist/ez_setup.py"
java -jar jython_installer-2.5.2.jar -s -d jython -t standard
./jython/bin/jython ez_setup.py
./jython/bin/easy_install docutils pygments jinja2 sphinx
