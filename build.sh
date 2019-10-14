#!/usr/bin/env bash

docker build -t buildkernel .
docker run -v $(pwd)/out:/out buildkernel \
  /bin/bash -c " \
  git clone -b custom https://github.com/cawilliamson/samsung_sm907b_kernel /usr/src/kernel && \
  cd /usr/src/kernel && \
  bash build_kernel.sh && \
  cp -fv /usr/src/kernel/arch/arm64/boot/Image /out/ && \
  chmod -v 777 /out/*"

