# gobackup for Kubernetes
This repository wraps [gobackup](https://github.com/huacnlee/gobackup) (and [dreitier's gobackup flavour](https://github.com/dreitier/gobackup)) and [interpolator](https://github.com/dreitier/interpolator) in a single, usable Docker image. 

## Description
[gobackup](https://github.com/huacnlee/gobackup) s a tool to dump databases and create backups of folders. It has various storage targets like `local`, `scp` and `S3`. Unfortunately, the current repository provides only the binary without any additional dependencies. You can easily deploy this Docker image into your Kubernetes cluster to create automatic backups.

## Getting started
- Mount the gobackup configuration file to `/etc/gobackup/config-raw.yaml`
- Placeholders in the configuration file like `${VAR}` are replaced by corresponding environment variables
- The resulting file is copied to `/etc/gobackup/gobackup.yaml`
- When **no arguments** are passed to the container, a simple `gobackup perform` is executed and the container exits.
- When periodic backups are desired, the container must be launched with the arguments `_cron ${cronExpression}` like so.

### Usage examples
Single backup:
```bash
docker run -v /path/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml dreitier/gobackup
``` 

Periodic backup every day at midnight:
```bash
docker run -v /path/to/my-gobackup-config.yaml:/etc/gobackup/config-raw.yaml dreitier/gobackup cron "0 0 * * *"
```

## Development
### Creating new releases
GitHub lacks the feature that repositories can easily subscribe to newer builds from upstream repository. Because of this, at the moment you have to manually push a tag to create a new gobackup release.

When creating a tag, use the tag format `${TAG}(-${GOBACKUP_GITHUB_REPOSITORY:huacnlee})?`. The first part before the `-` is the artifact, provided in the `${GOBACKUP_GITHUB_REPOSITORY}`. `${GOBACKUP_GITHUB_REPOSITORY}` is set to `huacnlee` by default.

#### Create a release based upon huacnlee's repository
```bash
docker tag v1.0.1
docker push v1.0.1 origin
```

#### Create a release based upon dreitier's repository
```bash
docker tag v1.0.1_custom_pr-dreitier
docker push v1.0.1_custom_pr-dreitier origin
```

## Changelog
The changelog is kept in the [CHANGELOG.md](CHANGELOG.md) file.

## Support
This software is provided as-is. You can open an issue in GitHub's issue tracker at any time. But we can't promise to get it fixed in the near future.
If you need professionally support, consulting or a dedicated feature, please get in contact with us through our [website](https://dreitier.com).

## Contribution
Feel free to provide a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
