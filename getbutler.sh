#!/usr/bin/env bash

_OS=`uname | tr "[:upper:]" "[:lower:]"`
_ARCH=amd64
_KIND=-head
_TARGET="https://broth.itch.ovh/butler/${_OS}-${_ARCH}${_KIND}/LATEST/archive/default"

# -L follows redirects
# -o specifies output name
# curl -L -o butler.zip https://broth.itch.ovh/butler/${_OS}-${_ARCH}${_KIND}/LATEST/archive/default
echo "downloading: "${_TARGET}
mkdir butler
curl -L -o butler/butler.zip https://broth.itch.ovh/butler/${_OS}-${_ARCH}${_KIND}/LATEST/archive/default
unzip butler/butler.zip -d butler
# GNU unzip tends to not set the executable bit even though it's set in the .zip
chmod +x butler/butler
# just a sanity check run (and also helpful in case you're sharing CI logs)
butler/butler -V
