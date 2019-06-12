if [ ! "$BASEDIR" ] || [ ! -d "$BASEDIR" ]; then
  echo "Cache base directory $BASEDIR is not set or does not exist."
  echo "Please set a correct cache directory in systemd configuration."
  exit 1
fi
getent hosts | grep lc- | while IFS=" " read -r ip name; do
#echo Name $name
#echo IP $ip

case $name in
  lc-generic)
    instance=${name:3}
    echo "GENERIC: cache configured with IP $ip"

    echo "LANCACHE_IP=$ip" >/run/lancache/dns
    echo "USE_GENERIC_CACHE=true" >>/run/lancache/dns

    # Configure generic cache
    echo "NAME=$instance" >/run/lancache/$instance
    echo "IP=$ip">>/run/lancache/$instance
    systemctl enable lancache@generic
    ;;
  *)
    instance=${name:3}
    echo "${instance^^}: cache uses IP $ip"

    echo "${instance^^}CACHE_IP=$ip" >>/run/lancache/dns

    # Configure cache instance
    echo "NAME=$instance" >/run/lancache/$instance
    echo "IP=$ip">>/run/lancache/$instance
    ;;
esac
done

exit 0