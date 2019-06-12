# lancache-systemd

This is just some quick hackery to get the docker images from https://hub.docker.com/r/lancachenet running on a server.

All files need to be copied to /opt/lancache (and the files in /systemd need to go in /etc/systemd/system).
The cache directory is currently set to /cache.

I'm uploading this because it may help someone setting this up more quickly.

After copying the files you'll need to configure cache instances using your local /etc/hosts file.

### Create entries in hosts file

Cache instances are prefixed (and recognized) by the prefix lc-.
The generic (monolithic) cache instance is configured by specifying an IP adress for lc-generic.
This instance should be always enabled to catch all data not handled by other instances.
To add more instances you can add more entries to your hosts file.

```sh
172.18.1.90   lc-generic
172.18.1.91   lc-riot
172.18.1.92   lc-steam
```

### Enable the main DNS service (which loads sniproxy automatically).

```sh
systemctl enable lancache-dns
systemctl start lancache-dns
```

### Start the cache instances

Example for Steam:

```sh
systemctl enable lancache@steam
systemctl start lancache@steam
```


## TODO
* Find a way to selectively disable caching for networks
* Change lancache@ from docker-compose to a docker run command to avoid restarting all caches when a new cache is added
* Add Steam Site License handling (https://hub.docker.com/r/lancachenet/steamcache-site-license) in addition to caching
