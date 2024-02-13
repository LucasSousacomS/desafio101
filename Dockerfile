# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

################################################################################
# Pick a base image to serve as the foundation for the other build stages in
# this file.
#
# For illustrative purposes, the following FROM command
# is using the alpine image (see https://hub.docker.com/_/alpine).
# By specifying the "latest" tag, it will also use whatever happens to be the
# most recent version of that image when you build your Dockerfile.
# If reproducability is important, consider using a versioned tag
# (e.g., alpine:3.17.2) or SHA (e.g., alpine@sha256:c41ab5c992deb4fe7e5da09f67a8804a46bd0592bfdf0b1847dde0e0889d2bff).
FROM ubuntu:20.04

################################################################################
# Create a stage for building/compiling the application.
#
# The following commands will leverage the "base" stage above to generate
# a "hello world" script and make it executable, but for a real application, you
# would issue a RUN command for your application's build process to generate the
# executable. For language-specific examples, take a look at the Dockerfiles in
# the Awesome Compose repository: https://github.com/docker/awesome-compose

#Seleção de diretório de trabalho no container
WORKDIR /app 
#Execução do comando "apt-get update no termina"
RUN apt-get update
#Instalação do GStreamer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
#Instalação do CUDA 12.1
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.debsudo dpkg -i cuda-keyring_1.0-1_all.debsudo apt-get updatesudo apt-get -y install cuda
#Instlação do CUDNN
RUN sudo apt-get -y install cudnn9-cuda-12
#Instalação do repositório CUDA
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.debsudo dpkg -i cuda-keyring_1.1-1_all.debsudo apt-get updatesudo apt-get -y install cuda-toolkit-12-3
#Instalação do TensorRT
RUN sudo apt-get install tensorrt-dev

#Selecionando a versão do CUDA e do TensorRT
RUN version="8.6.1-1+cuda12.1"
RUN sudo apt-get install tensorrt-dev=${version}
RUN sudo apt-mark hold tensorrt-dev
#Instalação do GCC para compilação dos códigos C++
RUN apt-get install -y gcc-4.4
#Comando inicial ao iniciar o container
CMD ["bash"]
