#!/bin/bash
USER="danhumassmed"
TAG="picard-trimmomatic"
VERSION="1.0.1"
SHORT_DESC="Software for Bioinformatics pipelines Picard & Trimmomatic"
echo "********************************************"
echo ../push_description.py -u \"${USER}\" -i ${USER}/${TAG} -r README.md -s \"${SHORT_DESC}\"

echo "********************************************"
echo docker buildx build --platform linux/amd64 --push -t ${USER}/${TAG}:${VERSION} .

echo "********************************************"
echo docker build -t ${USER}/${TAG}:${VERSION} .
echo docker push ${USER}/${TAG}:${VERSION}
echo "********************************************"
echo docker run -ti danhumassmed/picard-trimmomatic:1.0.1 picard-trimmomatic /bin/bash
echo docker run -t ${USER}/${TAG}:${VERSION} ${TAG} --version

