FROM golang:latest as builder

RUN apt-get update && apt-get install -y upx

# Set the Current Working Directory inside the container
WORKDIR /go/src/app

COPY . .

# Build the Go app for
RUN go build -ldflags "-s -w" -o main .

RUN strip main

RUN upx --brute main

# Start a new stage from scratch
FROM busybox:musl

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /go/src/app/main .

# Command to run the executable
CMD ["./main"]

