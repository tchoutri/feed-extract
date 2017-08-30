#!/usr/bin/env bash

echo "[+] Preparing release ${1}"
if [[ -z "${1}" ]]
then
  echo "[!] You really need to give me a version number, you know?"
else
  mkdir feed-extract-"${1}"
  stack clean
  stack build || exit 1
  FEEDEXTRACT_PATH=$(stack path --local-install-root)
  cp LICENSE.md README.md ${FEEDEXTRACT_PATH}/bin/feed-extract feed-extract-"${1}"/
  zip -rv feed-extract-"${1}".zip feed-extract-"${1}"
  rm -rf feed-extract-"${1}"
fi
