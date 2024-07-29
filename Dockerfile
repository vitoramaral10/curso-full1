FROM golang:latest

# Set the Current Working Directory inside the container
WORKDIR /go/src/app

COPY . .

# Build the Go app
RUN go build -o main .

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]


