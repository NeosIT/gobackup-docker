# Gobackup with Interpolator
### Sources
[Gobackup](https://github.com/huacnlee/gobackup)

[Interpolator](https://github.com/NeosIT/interpolator)

Both applications are packaged together in a single Docker image. Gobackup is a tool to dump databases and create backups of folders. It has various storage targets like local, scp and S3.
Interpolator is a tool which replaces Placeholders like ${VAR} in files by corresponding environment variables.

What this image does is that Interpolator processes Gobackup's config file first and Gobackup does it's job afterwards. Also, periodic backups are also possibe.

## Build
```bash
docker build . -t neosit/gobackup:latest
```

## Usage
- mount gobackup config file to _/etc/gobackup/config-raw.yaml_
- placeholders like _${VAR}_ are replaced by corresponding environment variables
- the resulting file is _/etc/gobackup/gobackup.yaml_
- when **no arguments** are passed to the container, a simple _gobackup perform_ is executed and the container exits
- when periodic backups are desired, the container must be launched with the arguments _cron ${cronExpression}_ like so
### Examples
Single backup:
```bash
docker run -v /patch/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml neosit/gobackup
``` 

Periodic backup every day at midnight:
```bash
docker run -v /patch/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml neosit/gobackup cron "0 0 * * *"
```