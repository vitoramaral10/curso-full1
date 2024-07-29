FROM golang:latest as builder

# Set the Current Working Directory inside the container
WORKDIR /go/src/app

COPY . .

# Build the Go app for
RUN go build -o main .

# Start a new stage from scratch
FROM alpine:latest

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /go/src/app/main .

# Command to run the executable
CMD ["./main"]

