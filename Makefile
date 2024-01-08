CONTAINER_COMMAND := buildah
BASE_IMAGE := container-registry.oracle.com/os/oraclelinux:9-slim
BASE_MAKEFILE := base/Containerfile

GMP_TAR_XZ := https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
GMP_VERSION := 6.3.0

MPFR_TAR_XZ := https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.xz
MPFR_VERSION := 4.2.1

MPC_TAR_GZ := https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
MPC_VERSION := 1.3.1

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
	  --build-arg MPFR_TAR_XZ=$(MPFR_TAR_XZ) \
	  --build-arg MPFR_VERSION=$(MPFR_VERSION) \
	  --build-arg MPC_TAR_GZ=$(MPC_TAR_GZ) \
	  --build-arg MPC_VERSION=$(MPC_VERSION) \
	  --build-arg BINUTILS_TAR_XZ=$(BINUTILS_TAR_XZ) \
	  --build-arg BINUTILS_VERSION=$(BINUTILS_VERSION) \
	  base/
	@touch $@
