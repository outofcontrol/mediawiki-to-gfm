#!/bin/bash
DOCKER_USERNAME=oooc
docker tag mediawiki-to-gfm $DOCKER_USERNAME/mediawiki-to-gfm
docker push $DOCKER_USERNAME/mediawiki-to-gfm
echo "now create a version tag and push that one:"
echo "docker tag mediawiki-to-gfm $DOCKER_USERNAME/mediawiki-to-gfm:version-1.0.1"
echo "docker push $DOCKER_USERNAME/mediawiki-to-gfm:version-1.0.1"
