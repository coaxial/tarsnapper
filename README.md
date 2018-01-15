# Tarsnapper Docker container

This container lets you run Tarsnapper on top of tarsnap. It uses configuration
files for tarsnap and tarsnapper, mounted inside the container.

It differs from [Dangmai's
conatainer](https://github.com/dangmai/docker-tarsnapper) in that it is based
on Alpine 3.6, and doesn't randomize the cron running period if not supplied.
It also runs `make` only, since `make` expires old backups as well. The image
also has tags (by tarnsapper version.)

This image is 102MB, vs 306MB for its Debian-based counterpart.

## Tags

`0.4`, `latest`

## Usage

```shell
docker run \
-v ./tarsnap.key:/root/tarsnap.key:ro \
-v ./tarsnap.conf:/etc/tarsnap.conf:ro \
-v ./tarsnapper.conf:/etc/tarsnapper.conf:ro \
-v /path/to/backup:/backup:ro \
-v tarnsap_cache:/usr/local/tarsnap-cache \
-e "BACKUP_PERIODICITY=* 3 * * *" \
coaxial/tarsnapper
```

If not set, `BACKUP_PERIODICITY` defaults to `* * * * 7` which translates to
making a backup every week on Sundays.

Define your images (cf. [tarsnapper
docs](https://github.com/miracle2k/tarsnapper#using-a-configuration-file)) in a
configuration file mounted at `/etc/tarsnapper.conf` and you're off to the
races.

## Contributing

PRs welcome, fork the repo and hack away.

## License

MIT (c) Coaxial 2018
