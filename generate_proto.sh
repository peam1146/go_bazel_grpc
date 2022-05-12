#! /bin/bash
for Dir in *; do
    if [ -d "$Dir" ]; then
        cd $Dir
        file=$(ls | grep ".proto$")
        if [ $file ]; then
            echo "proto file in $Dir is $file"
            # generate proto file
            protoc --go_out=. --go_opt=paths=source_relative \
                --go-grpc_out=. --go-grpc_opt=paths=source_relative \
                $file
        fi
        cd ..
    fi
done
