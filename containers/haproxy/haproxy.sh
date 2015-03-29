haproxy -f /usr/local/etc/haproxy/haproxy.cfg

die()
{
  exit 0
}

trap 'die' INT
trap 'die' TERM
while : ; do
  sleep 1
done
