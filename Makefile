CONTAINER_COMMAND := buildah
BASE_IMAGE := container-registry.oracle.com/os/oraclelinux:9-slim
BASE_CONTAINERFILE := base/Containerfile

GMP_VERSION := 6.3.0
GMP_TAR_XZ := https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.xz

MPFR_TAR_XZ := https://www.mpfr.org/mpfr-current/mpfr-4.2.1.tar.xz
MPFR_VERSION := 4.2.1

MPC_TAR_GZ := https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
MPC_VERSION := 1.3.1

BINUTILS_TAR_XZ := https://ftp.gnu.org/gnu/binutils/binutils-2.41.tar.xz
BINUTILS_VERSION := 2.41

# LAYERS true will cache intermediate layers. Useful when working on image modifications
LAYERS := true


BASE_IMG_DOWNLOADS := base/img-contents/.downloads

.PHONY: build

build: .build-stamp

.build-stamp: $(BASE_CONTAINERFILE)
	$(CONTAINER_COMMAND) build -f $(BASE_CONTAINERFILE) \
	  --layers=$(LAYERS) \
	  --tag base \
	  --build-arg BASE_IMAGE=$(BASE_IMAGE) \
	  --build-arg GMP_VERSION=$(GMP_VERSION) \
	  --build-arg MPFR_TAR_XZ=$(MPFR_TAR_XZ) \
	  --build-arg MPFR_VERSION=$(MPFR_VERSION) \
	  --build-arg MPC_TAR_GZ=$(MPC_TAR_GZ) \
	  --build-arg MPC_VERSION=$(MPC_VERSION) \
	  --build-arg BINUTILS_TAR_XZ=$(BINUTILS_TAR_XZ) \
	  --build-arg BINUTILS_VERSION=$(BINUTILS_VERSION) \
	  base/img-contents/
	@touch $@


external-deps: $(BASE_IMG_DOWNLOADS)/gmp-$(GMP_VERSION).tar.xz

$(BASE_IMG_DOWNLOADS)/gmp-$(GMP_VERSION).tar.xz:
	mkdir -p base/img-contents/.downloads
	curl -o $@ ${GMP_TAR_XZ}
