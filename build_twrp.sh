#!/usr/bin/env bash

docker build -t buildrecovery .
docker run \
  -v $(pwd)/common:/common \
  -v $(pwd)/out:/out \
  -v $(pwd)/src:/usr/src \
  buildrecovery \
  /bin/bash -c \
  "mkdir -p /usr/src/recovery && \
  cd /usr/src/recovery && \
  repo init \
    --depth=1 \
    -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git \
    -b twrp-9.0 && \
  mkdir -p .repo/local_manifests/ && \
  cp -v /common/manifests/local_manifest_winnerx.xml .repo/local_manifests/ && \
  # HACK - START
  rm -rf bootable/recovery
  # HACK - END
  repo sync -j$(nproc --all) && \
  # HACK - START
  rm -rf bootable/recovery && \
  git clone https://github.com/omnirom/android_bootable_recovery.git bootable/recovery && \
  cd bootable/recovery && \
  git reset --hard a895118a1fb88595d41c7e29b079d9f3c547258c && \
  cd ../.. && \
  # HACK - END
 . build/envsetup.sh && \
  lunch omni_winnerx-eng && \
  mka recoveryimage && \
  cp -fv /usr/src/recovery/out/target/product/winnerx/recovery.img /out/twrp.img && \
  chmod -v 777 /out/*"
