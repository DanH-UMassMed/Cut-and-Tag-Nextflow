#!/bin/bash
USER="danhumassmed"
TAG="samtools-bedtools"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines Samtools, Bedtools and MashMap"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"


echo "********************************************"
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .
