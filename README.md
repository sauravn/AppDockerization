# AppDockerization

Create a sample flask application and dockerize it

## Getting Started

These instructions will get you a copy of the project up and running on your docker container for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

1. Install Oracle VirtualBox on your laptop
2. Download and install a latest Ubuntu VM. 
3. Install updates and docker package.

### Installing

A step by step series of examples that tell you how to get a development env running

1.	If you don’t have a VM with docker installed, please get my sample ubuntu VM that you can directly boot using Virtual Box.
Path: /remote/vgrnd107/sauravn/UbuntuVM
2.	Please save the below code in a file named “Dockerfile” in the home directory of your VM.
```
FROM ubuntu:latest
MAINTAINER Docker OwnerName "something@something.com"
RUN apt-get update -y && apt-get install -y unzip zip
RUN apt-get install -y python-pip python-dev build-essential
RUN useradd -ms /bin/bash docker
RUN echo "docker:password" | chpasswd
RUN adduser docker sudo
WORKDIR /home/docker
ADD https://github.com/sauravn/AppDockerization/archive/master.zip /home/docker/AppDockerization-master.zip
RUN chown -R docker:docker /home/docker
RUN chmod 777 AppDockerization-master.zip
USER docker
RUN unzip AppDockerization-master.zip
WORKDIR /home/docker/AppDockerization-master
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["application.py"]
```
3.	Build docker file: 
```
$ sudo docker build -t sample-docker:latest .
```
4.	Check docker image: 
```
$ sudo docker images
```
5.	Run docker container: 
```
$ sudo docker run -d -p 5000:5000 sample-docker
```
6.	Check docker container: 
```
$ sudo docker ps
```
7.	Go to browser on your VM and type: 
```
http://0.0.0.0:5000
```
