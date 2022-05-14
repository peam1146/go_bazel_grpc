#! /bin/bash
if [ ! $(which protoc) ]; then
  echo "protoc not found: Please install protoc"
  exit 1
fi
PROTO_DIR="proto_tmp_01"
if [ ! -d "$PROTO_DIR" ]; then
  mkdir $PROTO_DIR
fi
# each file in current dir
for Dir in *; do
  if [ -d "$Dir" ]; then
    (
      cd "$Dir"
      file=$(ls | grep ".proto$")
      if [ "$file" ]; then
        yes | cp -r "$file" "../$PROTO_DIR"
      fi
    )
  fi
done
for Dir in *; do
  if [ -d "$Dir" -a "$Dir" != "$PROTO_DIR" ]; then
    (
      cd "$Dir"
      file=$(ls | grep ".proto$")
      if [ "$file" ]; then
        echo "proto file in $Dir is $file"
        protoc \
          --go_out=. --go_opt=paths=source_relative \
          --go-grpc_out=. --go-grpc_opt=paths=source_relative \
          --proto_path="../$PROTO_DIR" \
          "$file"
      fi
    )
  fi
done
rm -rf $PROTO_DIR
