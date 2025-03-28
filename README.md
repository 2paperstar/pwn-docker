# How to Use

register `run.sh` as a command.

```sh
sudo ln -s "$(pwd)/run.sh" /usr/local/bin/pwn-run
```

run the container.

```sh
pwn-run <version>
```

remove the container.

```sh
pwn-run <version> rm
```

# Development

change the `<version>/Dockerfile` and build with below command.

```sh
./build.sh <version>
```
