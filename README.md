# AppDockerization

Create a simple flask application and dockerize it

## Getting Started

These instructions will get you a copy of the project up and running on your docker container for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

#### OPTION-1
1. Get an EC2 instance with standard CentOS image installed.
2. Install docker package.

#### OPTION-2
1. Install Oracle VirtualBox on your laptop
2. Download and install a latest Ubuntu VM. 
3. Install updates and docker package.

### Installing

A step by step series of examples that tell you how to get a development env running

1.	Please save the below code in a file named “Dockerfile” in the home directory of your VM.
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

### Commands - Help
*ADD:*
  Takes as input a file and a destination. It essentially grabs files from the host machine (your computer) and places them inside the Docker image. You can also use url’s as arguments so that it downloads data from the internet into the Docker image instead, as well as decompressing files from known compression formats (I’ve been told not to trust this too much though). COPY does pretty much the same without the URL or decompression features.

 #### Usage: ADD [source directory or URL] [destination directory]
  ADD /my_app_folder /my_app_folder

*CMD:* 
It is used to run a specific command, but this command is executed at the moment of initiating the container, not when building the image. For example we would use CMD to run our python file when the image is initiated. If you want to run a command at the moment of building the image, we would use RUN, which I’ll describe later.

#### Usage: CMD application "argument", "argument", ..
```
CMD "echo" "Hello docker!"
```

*ENTRYPOINT:* 
Tells our image what is the default application we will be using for our commands. So if we were to tell our image that our entry point is “python” then, when we run CMD, we would just give it the arguments, as it would know that python is the application to use to run these commands.

#### Usage: ENTRYPOINT application "argument", "argument", ..

** Remember: arguments are optional. They can be provided by CMD
** or during the creation of a container. 
```
ENTRYPOINT echo
```

#### Usage example with CMD:
#### Arguments set with CMD can be overridden during *run*
```
CMD "Hello docker!"
ENTRYPOINT echo
```

*ENV:*
Sets environment variables by giving it a key = value pair. Really makes your life easier.

#### Usage: ENV key value
```
ENV SERVER_WORKS 4
```

*EXPOSE:*
It’s used to associate a specific port to communicate with other containers. I would avoid using EXPOSE, as usually the port redirection is done by each host at the moment of running. However it can be useful when having some inter-container communication. This StackOverflow answer is pretty good, take a look if you’re interested in reading more about it.

#### Usage: EXPOSE [port]
```
EXPOSE 8080
```

*FROM:* 
It needs to be the first command declared in the Dockerfile. It indicates what image you are basing your image on. It can be any image, even one you’ve made yourself before. If not in the machine, Docker will get it from DockerHub.

#### Usage: FROM [image name]
```
FROM ubuntu
```

*MAINTAINER:* 
Used to give yourself some credit. Can be placed anywhere, and it doesn’t execute.

#### Usage: MAINTAINER [name]
```
MAINTAINER authors_name
```

*RUN:* 
I mentioned it a bit earlier, this is how you run commands at the moment of building your Docker image. You would use this to install all dependencies your system will have, and have it ready to just go and run your application.

#### Usage: RUN [command]
```
RUN aptitude install -y riak
```

*USER:* 
Used to specify the uid or username of the user you want to run the container based on. This can be used to manage permissions to be had within the container. On my research I stumbled on this story that helps understand a bit more about uid and gid, check it out:

Understanding how uid and gid work in Docker containers

Understanding how usernames, group names, user ids (uid) and group ids (gid) map between the processes running inside a…
medium.com	
#### Usage: USER [UID]
```
USER 751
```

*VOLUME:* 
Allows a container to have access to a folder on the host machine.

#### Usage: VOLUME ["/dir_1", "/dir_2" ..]
```
VOLUME ["/my_files"]
```

*WORKDIR:* 
Indicates in which folder the CMD commands should be executed.

#### Usage: WORKDIR /path
```
WORKDIR ~/
```
