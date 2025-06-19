# Running on PUB400 (IBM i PASE)

This folder demonstrates how to deploy the Apache core dump protection example in your PUB400 account.

1. Set the environment variable `PUB400_USER` to your PUB400 username, e.g. `export PUB400_USER=XY1234`.
2. Run `./deploy.sh` from this directory. The script copies the sample files to your account and starts Apache on port 8080.
3. Test access using a browser or `curl http://pub400.com:8080/core.1234`. You should receive `403 Forbidden`.

The script requires `ssh` and `scp` access to PUB400 and assumes the open-source HTTP server (`httpd`) is available under `/QOpenSys/pkgs/bin/httpd`.
