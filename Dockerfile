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
