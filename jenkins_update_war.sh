#!/bin/bash

function get_latest_war_version {

  JENKINS_LATEST_VERSION=$(curl -q "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/maven-metadata.xml" | grep -oPm1 "(?<=<latest>)[^<]+");
  JENKINS_LATEST_VERSION_URL=$(echo "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_LATEST_VERSION}/jenkins-war-${JENKINS_LATEST_VERSION}.war");

  echo $JENKINS_LATEST_VERSION_URL;
}

echo "Downloading latest version of Jenkins...";
JENKINS_URL=$(get_latest_war_version);

wget $JENKINS_URL -O /usr/share/jenkins/jenkins.war
echo "Done"
