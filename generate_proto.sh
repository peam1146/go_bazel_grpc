#! /bin/bash
if [ ! $(which protoc) ]; then
    echo "protoc not found: Please install protoc"
    exit 1
fi
protoc --go_out=. --go_opt=paths=source_relative \
    --go-grpc_out=. --go-grpc_opt=paths=source_relative \
    ./proto/**/*.proto