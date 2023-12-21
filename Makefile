CONTAINER_COMMAND := buildah
BASE_IMAGE := container-registry.oracle.com/os/oraclelinux:9-slim
BASE_MAKEFILE := base/Containerfile

GMP_TAR_XZ := https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
GMP_VERSION := 6.3.0
BINUTILS_TAR_XZ := https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz
BINUTILS_VERSION := 2.41

# LAYERS true will cache intermediate layers. Useful when working on image modifications
LAYERS := true

.PHONY: build

build: .build-stamp

.build-stamp: $(BASE_MAKEFILE)
	$(CONTAINER_COMMAND) build -f $(BASE_MAKEFILE) \
	  --layers=$(LAYERS) \
	  --tag base \
	  --build-arg BASE_IMAGE=$(BASE_IMAGE) \
	  --build-arg GMP_TAR_XZ=$(GMP_TAR_XZ) \
	  --build-arg GMP_VERSION=$(GMP_VERSION) \
	  --build-arg BINUTILS_TAR_XZ=$(BINUTILS_TAR_XZ) \
	  --build-arg BINUTILS_VERSION=$(BINUTILS_VERSION) \
	  base/
	@touch $@
