# ComputeStacks WHMCS Container

**PHP 7.4 and OpenLitespeed**

[![Build Image](https://github.com/ComputeStacks/cs-docker-whmcs/actions/workflows/build-image.yml/badge.svg)](https://github.com/ComputeStacks/cs-docker-whmcs/actions/workflows/build-image.yml)

```bash

docker run -d --rm --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD="sUper3R4nd0m" mariadb:10.3

docker run --rm -it \
  -e LS_ADMIN_PW="changeme0" \
  -e DB_HOST="host.docker.internal" \
  -e DB_PORT="3306" \
  -e DB_USER="root" \
  -e DB_PASSWORD="sUper3R4nd0m" \
  -e DB_NAME="whmcs" \
  -p 3000:80 \
  -p 7080:7080 \
  cmptstks/whmcs:php7.4-litespeed /sbin/my_init -- bash -l
```
  
## Submitting Issues

If you encounter a technical issue, you may [open an issue](https://github.com/ComputeStacks/cs-docker-whmcs/issues). However, for questions or how-to's, please [post on our forum](https://forum.computestacks.com).


## Contributing

Contributions are welcome! Before you submit a pull request, feel free to [post on our forum](https://forum.computestacks.com) your idea and we can have a discussion.

