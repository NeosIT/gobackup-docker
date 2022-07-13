# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
the project does __not__ use [Semantic Versioning](https://semver.org/spec/v2.0.0.html) as it would conflict with the versioning of `gobackup`.

## [0.20220713.0] - 2022-07-13
### Added
- GitHub Actions workflow has been added
- On a tag push for this repository, a Docker image will be created and pushed to https://hub.docker.com/repository/docker/dreitier/gobackup.

### Changed
- `gobackup` base image is now based upon Fedora 36 and the latest MongoDB utilities.
- Instead of building `gobackup` and `interpolator` on our own, we are using the existing artifacts (binary releases for gobackup, binary from the interpolator Docker image).

## [0.13.0] - 2019-11-12
- bumped gobackup to 0.11.0
- updated to Fedora 31 base image
- updateed to PostgreSQL 12 client tools

## [0.12.0] - 2019-11-04
- bumped gobackup to 0.10.1

## [0.11.0] - 2019-10-07
- build from neosit/gobackup instead of the original repo
- dropped patches

## [0.10.0] - 2019-09-26
- added several system packages to aid debugging

## [0.9.2] - 2019-09-06
- use specific version of interpolator instead of latest commit
- improved crontab

## [0.9.1] - 2019-09-05
- fixes for cron on Fedora

## [0.9.0] - 2019-09-04
inital release