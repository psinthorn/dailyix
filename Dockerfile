# Build stage
FROM golang:1.18-alpine3.15 as builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run stage 
FROM alpine:3.15
WORKDIR /app
COPY --from=builder /app/main .
COPY app.env .

EXPOSE 9090
RUN ["/app/main"]
