#!/bin/bash
USER="danhumassmed"
TAG="bowtie-tophat"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines Bowtie[1,2] & Tophat[1,2]"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

echo "********************************************"
echo docker buildx build --platform linux/amd64,linux/arm64 --push -t ${USER}/${TAG}:${VERSION} .

echo "********************************************"
echo docker build -t ${USER}/${TAG}:${VERSION} .
echo docker push ${USER}/${TAG}:${VERSION}
echo "********************************************"
echo docker run -t ${USER}/${TAG}:${VERSION} ${TAG} --version

