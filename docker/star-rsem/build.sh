#!/bin/bash
USER="danhumassmed"
TAG="star-rsem"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines STAR and RSEM"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"


echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
