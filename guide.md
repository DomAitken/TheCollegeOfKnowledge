# Docker Guide
[PluralSight GitHub repo](https://github.com/nigelpoulton/gsd.git)

## Basic Commands
List all images
```
docker image ls
```
List all containers (-a lists all non-running containers)
```
docker container ls -a
```
Builds an image with files in current directory
```
docker image build -t <docker id>/<repo>:<image name> .
```
Run container (-d means run it detached)
```
docker container run -d --name <name> -p 8000:8000 <image id>
```   
Run container with interactable shell
```docker container run -it --name <name> alpine sh
```
Stop Container
```
docker container stop <container id>
```
Delete container
```
docker container rm <container id>
```

## dockerfile
A file that consists if a set of build instructions for Docker to build the app and its dependencies into a container image.\
Example:-
```
# Test web app that returns the name of the host/pod/container servicing req
# Linux x64
FROM node:current-alpine

LABEL org.opencontainers.image.title="Hello Docker Learners!" \
      org.opencontainers.image.description="Web server showing host that responded" \
      org.opencontainers.image.authors="@nigelpoulton"

# Create directory in container image for app code
RUN mkdir -p /usr/src/app

# Copy app code (.) to /usr/src/app in container image
COPY . /usr/src/app

# Set working directory context
WORKDIR /usr/src/app

# Install dependencies from packages.json
RUN npm install

# Command for container to execute
ENTRYPOINT [ "node", "app.js" ]
```
