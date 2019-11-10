#!/usr/bin/env bash

docker build -t buildrecovery .
docker run \
  -v $(pwd)/common:/common \
  -v $(pwd)/out:/out \
  buildrecovery \
  /bin/bash -c \
  "mkdir -p /usr/src/recovery
  cd /usr/src/recovery
  repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0 && \
  test -f "/usr/src/recovery/.repo/repo/repo" && mv -f "/usr/src/recovery/.repo/repo/repo" "/usr/local/bin/repo" && \
  mkdir -p .repo/local_manifests/ && \
  cp -v /common/manifests/local_manifest_winner.xml .repo/local_manifests/ && \
  repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags && \
  export ALLOW_MISSING_DEPENDENCIES=true && \
  . build/envsetup.sh && \
  lunch omni_winnerx-eng && \
  mka recoveryimage && \
  cp -fv /usr/src/recovery/out/target/product/winner/recovery.img /out/recovery.img && \
  chmod -v 777 /out/*"
