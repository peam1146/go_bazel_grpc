#! /bin/bash
if [ ! $(which protoc) ]; then
    echo "protoc not found: Please install protoc"
    exit 1
fi
# each file in current dir
for Dir in *; do
    # if dir
    if [ -d "$Dir" ]; then

        cd "$Dir"
        # get proto file
        file=$(ls | grep ".proto$")

        # if file exist
        if [ "$file" ]; then
            echo "proto file in $Dir is $file"
            # generate proto file
            protoc --go_out=. --go_opt=paths=source_relative \
                --go-grpc_out=. --go-grpc_opt=paths=source_relative \
                "$file"
        fi
        cd ..
    fi
done
