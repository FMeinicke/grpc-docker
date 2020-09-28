# grpc-docker
Docker image to build gRPC from source

https://hub.docker.com/r/fmeinicke/grpc-docker

By default this image builds gRPC as a shared library.
You can control this behaviour by setting the `GRPC_BUILD_SHARED_LIBS` variable on the command line when building the image.  
To force building a static library use:
```shell
$ docker build --build-arg GRPC_BUILD_SHARED_LIBS=OFF .
```

> #### Note: 
> This image configures gRPC to use the system OpenSSL libraries rather than gRPC's included boringssl.
> This is to make it possible for applications using gRPC *as well as* OpenSSL to run without problems.
> If gRPC was built with boringssl but your application (using gRPC, of course) used OpenSSL then you'd get all kinds of weird errors.
> By telling gRPC to use the system's OpenSSL these issues can be avoided.  
> If you'd still like to use boringssl feel free to remove the line `-DgRPC_SSL_PROVIDER=package` in the [Dockerfile](Dockerfile) and build the image yourself.
