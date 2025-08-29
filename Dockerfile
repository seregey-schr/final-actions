# Указываем базовый образ Go
FROM golang:1.24.1-alpine AS build

# Устанавливаем рабочую директорию
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main .

FROM alpine:latest
WORKDIR /
COPY --from=build /main /main

CMD ["/main"]
