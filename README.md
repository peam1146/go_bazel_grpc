# Go gRPC monorepo with Bazel
run server
```
bazel run //:go-server
```
run client
```
bazel run //:go-client
```
generate BUILD.bazel
```
bazel run //:gazelle
```
update go dependencies
```
bazel run //:gazelle-update-repos
```