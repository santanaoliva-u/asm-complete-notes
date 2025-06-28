FROM ubuntu:24.04
RUN apt-get update && apt-get install -y nasm gdb python3 python3-pip
RUN pip3 install pwntools
WORKDIR /workspace
VOLUME /workspace
CMD ["bash"]
