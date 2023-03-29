## Build
FROM golang:1.20-alpine3.17 AS build

WORKDIR /app

COPY *.go ./

RUN go mod init api &&\
    go mod tidy &&\
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api main.go

## Deploy
FROM alpine:3.17

WORKDIR /app

COPY --from=build /app/api ./

EXPOSE 8080

USER nobody:nobody

ENTRYPOINT ["/app/api"]