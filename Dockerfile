FROM docker.io/golang:1.21-alpine3.18 as builder

ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux go build -o main .
######## Start a new stage from scratch #######
FROM docker.io/alpine:3.18.2

RUN apk update && apk add --no-cache bash curl jq
COPY --from=builder /app/main .
# Command to run the executable
CMD ["./main"]