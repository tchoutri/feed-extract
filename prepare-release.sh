#!/usr/bin/env bash

echo "[+] Preparing release ${1}"
mkdir feed-extract-${1}
cp LICENSE.md README.md .stack-work/install/x86_64-linux-tinfo6/lts-9.1/8.0.2/bin/feed-extract feed-extract-${1}/
zip -rv feed-extract-${1}.zip feed-extract-${1}
