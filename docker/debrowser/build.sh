#!/bin/bash
USER="danhumassmed"
TAG="debrowser"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines DEBrowser"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

#docker build -t danhumassmed/wormcat_batch:1.0.1 .
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
echo "********************************************"
echo "docker run --platform linux/amd64 -p 8088:8088 -t ${USER}/${TAG}:${VERSION} "