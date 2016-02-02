FROM scratch
COPY server logo.png ./
ENTRYPOINT ["./server"]
