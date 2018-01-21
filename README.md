# Tarsnapper Docker container

This container lets you run Tarsnapper on top of tarsnap. It uses configuration
files for tarsnap and tarsnapper, mounted inside the container.

## Differences with [Dangmai's tarsnapper](https://github.com/dangmai/docker-tarsnapper)

- Based on Alpine 3.6 (smaller image, 102MB vs 306MB)
- Doesn't randomize the cron running time if not supplied
- Runs `make` only, since `make` expires old backups as well.
- Images are tagged by tarsnapper versions
- Only runs `tarsnap --fsck` when statring the container vs with every backup (it costs money to run since it transfers data from tarsnap)

## Tags

By tarsnapper version: `0.4`, `latest`

## Usage

```shell
docker run \
-v ./tarsnap.key:/root/tarsnap.key:ro \
-v ./tarsnap.conf:/etc/tarsnap.conf:ro \
-v ./tarsnapper.conf:/etc/tarsnapper.conf:ro \
-v /path/to/backup:/backup:ro \
-v tarnsap_cache:/usr/local/tarsnap-cache \
-e "BACKUP_PERIODICITY=* 3 * * *" \
coaxial/tarsnapper:0.4
```

If not set, `BACKUP_PERIODICITY` defaults to `* * * * 7` which translates to
making a backup weekly on Sundays. Uses the crontab format.

Define your jobs (cf. [tarsnapper
docs](https://github.com/miracle2k/tarsnapper#using-a-configuration-file)) in a
configuration file mounted at `/etc/tarsnapper.conf` and you're off to the
races.

## Alternatives

- [dangmai/tarsnapper](https://hub.docker.com/r/dangmai/tarsnapper/)
- [atmoz/tarsnap](https://hub.docker.com/r/atmoz/tarsnap/)

## Contributing

PRs welcome, fork the repo and hack away.

## License

MIT (c) Coaxial 2018
