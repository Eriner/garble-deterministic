#!/usr/bin/env zsh

if ! [[ ${OSTYPE} =~ "darwin*" ]]; then
  print "only support mac shasum"
  # modify w/ sha256sum as needed
  exit 1
fi

_out=$(mktemp -d)

_build() {
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 garble -literals -seed="$(echo abcdefghijklmnop | base64)" -tiny build -o ${_out}/garble-test .
  shasum -a 256 ${_out}/garble-test
  rm -f ${_out}/garble-test
}

go clean -cache
_build
go clean -cache
_build
