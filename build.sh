#!/bin/sh

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

docker build -t "pwn:$VERSION" -f "$VERSION/Dockerfile" --platform linux/amd64 .
