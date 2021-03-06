FROM ubuntu:20.04 AS builder

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update \
    #
    # Install C++ tools and gRPC requirements
    && apt-get install -yq git make g++ cmake ninja-build \
                           libssl-dev autoconf libtool pkg-config golang \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

# Get & build gRPC
# see https://grpc.io/docs/quickstart/cpp/ for more info
ENV GRPC_INSTALL_DIR=/usr/local
ENV GRPC_VERSION=v1.31.0
# specify GRPC_BUILD_SHARED_LIBS on the command line using docker build --build-arg
ARG GRPC_BUILD_SHARED_LIBS=ON
RUN git clone --depth 1 --recurse-submodules -j 4 -b $GRPC_VERSION https://github.com/grpc/grpc \
    && cd grpc \
    && mkdir -p cmake/build && cd cmake/build \
    && cmake ../.. \
        -GNinja \
        -DgRPC_INSTALL=ON \
        -DgRPC_BUILD_TESTS=OFF \
        -DgRPC_SSL_PROVIDER=package \
        -DCMAKE_INSTALL_PREFIX=$GRPC_INSTALL_DIR \
        -DBUILD_SHARED_LIBS=$GRPC_BUILD_SHARED_LIBS \
    && cmake --build . && cmake --install .

FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local
RUN ldconfig
