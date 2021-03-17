FROM golang:1.7.3
WORKDIR /go/src/test
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main

FROM alpine:latest
WORKDIR /root/
COPY --from=0 /go/src/test/main .
CMD ["./main"]