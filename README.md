# ubuntu-ssh
A docker image for ubuntu linux server with ssh enabled for automation

### Currently Supported
* linux/amd64
* linux/arm64

### Login with below credentials

```
$ root
$ root123
```

### Steps

```shell
# From ghcr, only linux/amd64 available
docker pull ghcr.io/arumugamsubramanian/ubuntu-ssh:main
docker run -d --rm --name ubuntu-ssh -p 2222:22 ghcr.io/arumugamsubramanian/ubuntu-ssh:main
```

```shell
# From Docker Hub
docker pull arumugamsubramanian/ubuntu-ssh:main
docker run -d --rm --name ubuntu-ssh -p 2222:22 arumugamsubramanian/ubuntu-ssh:main
```

### login from host
```shell
ssh root@localhost -p 2222
```
if you are facing any issues related to known hosts, delete the older rsa key
```
cat /Users/arumugamsubramanian/.ssh/known_hosts | nl
```

### login from another container through Docker container IP
```shell
IPAddress=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu-ssh)
echo $IPAddress
```