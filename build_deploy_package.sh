#!/bin/bash

#
# Runs the weasyprint building script in a Docker container.
#

docker run --rm -v "$PWD":/var/task \
    lambci/lambda:build-python3.6 /var/task/package_weasyprint.sh
