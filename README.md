# grpc-docker

![docker publish](https://github.com/FMeinicke/grpc-docker/actions/workflows/docker-publish.yml/badge.svg)

Docker image to build gRPC from source

https://hub.docker.com/r/fmeinicke/grpc-docker

## Build arguments
You can control certain options of the build process of gRPC when building the image.
The general syntax for this is
```shell
$ docker build --build-arg <ARGUMENT>=<VALUE> .
```
Here, `<ARGUMENT>` is the name of any of the following build arguments and `<VALUE>` is a valid value for this argument. 
See the individual arguments' documentation for possible valid values.

### `GRPC_VERSION`
Specify which version of gRPC to build.  
By default the latest commit from the `master` branch is used.  
Other valid values include any branch or tag name of the [gRPC repository], e.g. `v1.39.x` for the latest version branch or `v1.39.1` for the latest tag (as of time of writing this).

### `GRPC_SSL_PROVIDER`
Specify whether to use the system's OpenSSL libraries or the ones included with gRPC as a submodule.  
By default this image configures gRPC to use the system OpenSSL libraries rather than gRPC's included boringssl (i.e. `GRPC_SSL_PROVIDER=package`).
This is to make it possible for applications using gRPC *as well as* OpenSSL to run without problems.
If gRPC was built with boringssl but your application (using gRPC, of course) used OpenSSL then you'd get all kinds of weird errors.
By telling gRPC to use the system's OpenSSL these issues can be avoided.  
If you'd still like to use boringssl set `-GRPC_SSL_PROVIDER=module`.

### `GRPC_BUILD_SHARED_LIBS`
Specify whether to build gRPC as a static or shared library.  
By default this image builds gRPC as a static library, i.e. this option is set to `OFF`.  
Setting this option to `ON` builds gRPC as a shared library.

[gRPC repository]: https://github.com/grpc/grpc
