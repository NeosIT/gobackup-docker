# GoBackup with Interpolator
## Sources
[GoBackup](https://github.com/huacnlee/gobackup)

[Interpolator](https://github.com/dreitier/interpolator)

Both applications are packaged together in a single Docker image. [GoBackup](https://github.com/huacnlee/gobackup) is a tool to dump databases and create backups of folders. It has various storage targets like `local`, `scp` and `S3`.
[Interpolator](https://github.com/dreitier/interpolator) is a tool which replaces placeholders like `${VAR}` in files by corresponding environment variables.

What this image does is that [Interpolator](https://github.com/dreitier/interpolator) processes [GoBackup](https://github.com/huacnlee/gobackup)'s config file first and [GoBackup](https://github.com/huacnlee/gobackup) does it's job afterwards. Periodic backups are also possibe.

## Build
```bash
docker build . -t dreitier/gobackup:latest
```

## Usage
- mount gobackup config file to `/etc/gobackup/config-raw.yaml`
- placeholders like `${VAR}` are replaced by corresponding environment variables
- the resulting file is `/etc/gobackup/gobackup.yaml`
- when **no arguments** are passed to the container, a simple `gobackup perform` is executed and the container exits
- when periodic backups are desired, the container must be launched with the arguments `_cron ${cronExpression}` like so

### Examples
Single backup:
```bash
docker run -v /path/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml dreitier/gobackup
``` 

Periodic backup every day at midnight:
```bash
docker run -v /path/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml dreitier/gobackup cron "0 0 * * *"
```
