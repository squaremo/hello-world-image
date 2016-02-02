FROM ubuntu
WORKDIR /home/weave
ENTRYPOINT ["./server"]
EXPOSE 80/tcp
COPY server logo.png index.template ./
