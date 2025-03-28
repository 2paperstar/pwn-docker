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

if docker inspect "pwn-$VERSION" >/dev/null 2>&1; then
  MOUNT_DIR=$(docker inspect "pwn-$VERSION" -f "{{with index .Mounts 0}}{{.Source}}{{end}}")
  if [[ "$(pwd)" != "$MOUNT_DIR"* ]]; then
    echo "Warning: Current directory differs from original mount. Container will mount current directory."
    echo "Do you want to stop and remove the existing container? (yes/no)"
    read answer
    if [ "$answer" = "yes" ]; then
      docker stop "pwn-$VERSION" >/dev/null || true
      docker rm "pwn-$VERSION" >/dev/null || true
    fi
  fi
fi

docker start "pwn-$VERSION" >/dev/null ||
  docker run -d --name "pwn-$VERSION" --platform linux/amd64 -it -v "$(pwd):/pwn" "pwn:$VERSION"
docker exec -it "pwn-$VERSION" /bin/zsh
