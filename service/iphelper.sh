NAME=$1
IP=$(getent hosts lc-$1 | awk '{print $1'})
if [ -z $IP ]; then
  echo "Service $1 has no configured IP address. Please add an entry for lc-$1 to your systems hosts file"
  exit 127
fi
echo "NAME=${1}">/run/lancache/${NAME}
echo "IP=${IP}">>/run/lancache/${NAME}
