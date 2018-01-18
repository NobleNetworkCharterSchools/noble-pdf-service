#!/bin/bash

# Creates a zipped deployment package for upload to AWS Lambda.
# This script is intended to run in a Lambda-like (Docker)
# environment in order to retrieve the necessary dependencies.

set -u
set -e

# assumes cwd mounted to /var/task in container
DOCKER_DIST_DIR=/var/task/dist
DEPLOYMENT_ZIP=deployment.zip

echo "Preparing $DOCKER_DIST_DIR"
[ -d $DOCKER_DIST_DIR ] && rm -rf "$DOCKER_DIST_DIR"/* \
                        || mkdir "$DOCKER_DIST_DIR"

echo "Copying src to $DOCKER_DIST_DIR"
cp src $DOCKER_DIST_DIR

echo "Installing pip dependencies to $DOCKER_DIST_DIR"
pip install --requirement requirements.txt --target $DOCKER_DIST_DIR

echo "Installing system dependencies and copying to $DOCKER_DIST_DIR"
yum install -y pango

# move system dependencies; some need renaming
cp /usr/lib64/libpangocairo-1.0.so.0 "$DOCKER_DIST_DIR"/pangocairo-1.0
cp /usr/lib64/libpango-1.0.so.0 "$DOCKER_DIST_DIR"/pango-1.0
cp /usr/lib64/libpangox-1.0.so.0 "$DOCKER_DIST_DIR"
cp /usr/lib64/libpangoxft-1.0.so.0 "$DOCKER_DIST_DIR"
cp /usr/lib64/libpangoft2-1.0.so.0 "$DOCKER_DIST_DIR"

echo "Removing unnecessary packages"
rm -rf "$DOCKER_DIST_DIR"/pip*
rm -rf "$DOCKER_DIST_DIR"/__pycache__

#cd dist/; zip -r deployment.zip . 1> /dev/null
#cd ..
#mv dist/deployment.zip .
#echo "Removing dist/.."
#rm -rf dist/
