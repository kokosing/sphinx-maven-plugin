#!/bin/bash
set -eux
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]:-$0}); pwd)
BASE_DIR=$(cd "$SCRIPT_DIR/../../.."; pwd)
WORK_DIR="target/sphinx-tmp"

/bin/bash "$SCRIPT_DIR/setup-jython-env.sh"

pushd "$BASE_DIR" > /dev/null
cd $WORK_DIR
jar cf sphinx.jar -C jython/Lib/site-packages/Sphinx*/ sphinx
jar uf sphinx.jar -C jython/Lib/site-packages/Jinja2*/ jinja2
jar uf sphinx.jar -C jython/Lib/site-packages/docutils*/ docutils
jar uf sphinx.jar -C jython/Lib/site-packages/Pygments*/ pygments
jar uf sphinx.jar -C jython/Lib/site-packages/imagesize*/ imagesize
jar uf sphinx.jar -C jython/Lib/site-packages/alabaster*/ alabaster
jar uf sphinx.jar -C jython/Lib/site-packages/Babel*/ babel
jar uf sphinx.jar -C jython/Lib/site-packages/snowballstemmer*/ snowballstemmer
jar uf sphinx.jar -C jython/Lib/site-packages/six*/ six.py
jar uf sphinx.jar -C jython/Lib/site-packages/typing*/ typing.py
jar uf sphinx.jar -C jython/Lib/site-packages pkg_resources
jar uf sphinx.jar -C jython/Lib/site-packages/pytz*/ pytz
jar uf sphinx.jar -C jython/Lib/site-packages/MarkupSafe*/ markupsafe
jar uf sphinx.jar -C jython/Lib/site-packages/requests*/ requests
jar uf sphinx.jar -C jython/Lib/site-packages/certifi*/ certifi
jar uf sphinx.jar -C jython/Lib/site-packages/chardet*/ chardet
jar uf sphinx.jar -C jython/Lib/site-packages/idna*/ idna
jar uf sphinx.jar -C jython/Lib/site-packages/urllib3*/ urllib3
mv sphinx.jar "$BASE_DIR/src/main/resources/"
popd > /dev/null

echo "Done!"
