# grpc-docker
Docker image to build gRPC from source

By default this image builds gRPC as a shared library.
You can control this behaviour by setting the `GRPC_BUILD_SHARED_LIBS` variable on the command line when building the image.  
To force building a static library use:
```shell
$ docker build --build-arg GRPC_BUILD_SHARED_LIBS=OFF .
```
