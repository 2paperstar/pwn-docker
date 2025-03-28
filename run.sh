#!/bin/sh

VERSION=$1

if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

if [ "$2" = "rm" ]; then
  docker stop "pwn-$VERSION" >/dev/null || true
  docker rm "pwn-$VERSION" >/dev/null || true
  exit 0
fi

docker start "pwn-$VERSION" >/dev/null ||
  docker run -d --name "pwn-$VERSION" --platform linux/amd64 -it -v "$(pwd):/pwn" "pwn:$VERSION"
docker exec -it "pwn-$VERSION" /bin/zsh
