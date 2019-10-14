#!/usr/bin/env bash

docker build -t buildkernel .
docker run \
  -v $(pwd)/common:/common \
  -v $(pwd)/out:/out \
  buildkernel \
  /bin/bash -c " \
  git clone -b custom https://github.com/cawilliamson/samsung_sm907b_kernel /usr/src/kernel && \
  cd /usr/src/kernel && \
  bash build_kernel.sh && \
  cd /var/tmp && \
  cp -fv /common/imgs/recovery.img recovery.img && \
  /common/bin/magiskboot unpack recovery.img && \
  cp -fv /usr/src/kernel/arch/arm64/boot/Image kernel && \
  /common/bin/magiskboot repack recovery.img new-recovery.img && \
  cp -fv /var/tmp/new-recovery.img /out/patched-recovery.img && \
  chmod -v 777 /out/*"
