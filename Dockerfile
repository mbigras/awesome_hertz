FROM golang:1.14 AS builder
WORKDIR /app
COPY Makefile go.mod main.go /app/
RUN make build

FROM alpine:latest  
WORKDIR /app/
COPY --from=builder /app/awesome_hertz /app/
ENTRYPOINT ["/app/awesome_hertz"]
