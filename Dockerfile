# Builder stage: Build the Go application
FROM golang:1.20 AS builder
WORKDIR /app

# Copy Go modules and source code
COPY go.mod go.sum ./
RUN go mod download
COPY . ./

# Build the Go application
RUN go build -o app main.go

# Runtime stage: Use Ubuntu 22.04 with the correct GLIBC version
FROM ubuntu:22.04
WORKDIR /root

# Install SQLite
RUN apt-get update && apt-get install -y sqlite3 && apt-get clean

# Copy the application binary and database initialization script
COPY --from=builder /app/app .
COPY init_db.sql /root/init_db.sql

# Initialize the SQLite database
RUN mkdir -p /root/data && sqlite3 /root/data/test.db < /root/init_db.sql

# Set the default command
CMD ["./app"]

