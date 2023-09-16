# ubuntu-ssh
A docker image for ubuntu linux server with ssh enabled for automation

### Login with below credentials

```
$ root
$ root123
```

### Steps

```shell
docker pull ghcr.io/arumugamsubramanian/ubuntu-ssh:main
docker run -d --rm --name ubuntu-ssh -p 2222:22 ghcr.io/arumugamsubramanian/ubuntu-ssh:main
```

### login from host
```shell
ssh root@localhost -p 2222
```

### login from another container through Docker container IP
```shell
IPAddress=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu-ssh)
echo $IPAddress
```