if [ ! -f /path/to/file ]
then
  /usr/local/bin/panamax init /mirror
fi

/usr/local/bin/panamax sync /mirror

/usr/local/bin/panamax serve /mirror
