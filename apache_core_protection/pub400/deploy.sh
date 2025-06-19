#!/bin/sh
# Deploy Apache core dump protection example to PUB400
# Usage: PUB400_USER=XY1234 ./deploy.sh
set -e

if [ -z "$PUB400_USER" ]; then
  echo "Set PUB400_USER to your PUB400 username" >&2
  exit 1
fi
REMOTE="${PUB400_USER}@pub400.com"
DIR="$(dirname "$0")/.."

# Copy files to remote host
scp "$DIR/index.html" "$DIR/core.1234" "$DIR/core.dump" \
    "$DIR/core_deny.conf" "$REMOTE:~/core_example/"

# Run remote setup
ssh "$REMOTE" <<'EOS'
set -e
cd ~/core_example
mkdir -p htdocs conf
mv index.html htdocs/
mv core.1234 core.dump htdocs/
mv core_deny.conf conf/

cat > httpd.conf <<CONFIG
ServerRoot "/QOpenSys/etc/httpd"
Listen 8080
LoadModule mpm_prefork_module /QOpenSys/pkgs/lib/httpd/modules/mod_mpm_prefork.so
LoadModule authz_core_module /QOpenSys/pkgs/lib/httpd/modules/mod_authz_core.so
LoadModule mime_module /QOpenSys/pkgs/lib/httpd/modules/mod_mime.so
LoadModule dir_module /QOpenSys/pkgs/lib/httpd/modules/mod_dir.so
LoadModule unixd_module /QOpenSys/pkgs/lib/httpd/modules/mod_unixd.so
User nobody
Group nobody

DocumentRoot "$(pwd)/htdocs"
<Directory "$(pwd)/htdocs">
    Options -Indexes +FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>

Include "$(pwd)/conf/core_deny.conf"
CONFIG

/QOpenSys/pkgs/bin/httpd -f $(pwd)/httpd.conf -k start
EOS
