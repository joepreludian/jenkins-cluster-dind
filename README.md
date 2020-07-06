# Jenkins Cluster Docker In Docker
An implementation of a fully functional Jenkins Cluster within docker containers with full pipelines support using a Docker in Docker container.

# Introduction
This repository aims to create an almost zero configuration jenkins server for for building your projects. Once Jenkins is fully customizable and it has a lot of available plugins, this build is an opinionated distributions used on my daily work.

Basically I use the pipeline with Docker on a jenkins instance.

# How is it possible?

I'm using a composition file in order to create the following structure:

* Jenkins Container -> It will have the latest version of Jenkins (lts), from oficial Docker container;
* DIND -> It is a Docker In Docker (DIND) container, from official Docker Hub image (docker:stable-dind);
* Build Node -> A simple ubuntu container with a SSH server, docker and docker-compose command line tools connected to DIND container.

# But what? What DIND Means?

It's a nice feature to have when dealing with Jenkins and Docker. We already know the power of Docker and how can we leverage the way that we design software. The new thing is when you need docker to create containers that will build something for you. What's the idea here? I would like to create a fully working docker server that doesn't interactes with the real world Docker server and stills adds me the ability to build my containers like if I was the docker host with a standalone Jenkins.

But again, why? The answer is that I wanted that the Jenkins and It's configurations would be pulled like any regular docker container, using the good parts of docker. As the result we would have:

* A Docker server
  * A Jenkins Container using the latest version of Jenkins with it own Java and settings;
  * A Docker Container which have a Docker server built in (Docker In Docker)
  * A bridge container which it will be used by the Jenkins container in order to interface the docker in docker container.

# How to run this project?

First of all you will need to have working Docker on your machine as well as Docker Compose.
In order to use this project you will just need to clone this repo and then run the following command:

    $ docker-compose up -d

It will create all the containers as well as the links among them, but it will create an empty configuration.
Point your browser and you will see a cleanup Jenkins available for using.

All of your configuration will be created on the folder "jenkins\_home" inside your project directory; Credentials, hosts, nodes, plugins (and etc) will be put on that directory, to it's most likely that it will have a huge size. It's strongly recommended that you backup this folder in order to have your settings keeping safe and sound.

## Starting from a preconfigured instance (recommended)
s
I created a container which have a preconfigured jenkins pointing to the node. The actual docker-compose already have this configuration set up.

On the jenkins container you can use the following images:

* joepreludian/my\_jenkins:latest -> For an empty jenkins\_home (It will created from zero by Jenkins; Useful for advanced users)
* joepreludian/my\_jenkins:base -> It is a jenkins pre-installed offering with the node set up. Recommended.

The base image will be used by default. In order to change it, just edit the docker-compose.yml and override the image by the one you want.

# Todo

- [] Create a video teaching how to setup your jenkins instance from zero;
- [] Create a CI/CD Pipeline for the Docker Image

# Missing something?

Create an issue on github! Thanks!
