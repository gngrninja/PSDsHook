# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/).
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.6] Unreleased

### Adding
- Support for file sending in PowerShell 5.1
- Coming soon

## [0.1.5] 2018-11-03

### Added
- Support for PowerShell 5.1! 5.1 users cannot use the file sending feature yet(multi part form data I'm looking at you!), but everything else is working.

## [0.1.4] 2018-10-24

### Added
- [Author](https://discordapp.com/developers/docs/resources/channel#embed-object-embed-author-structure) object added, and can be added to the EmbedBuilder.
- [Footer](https://discordapp.com/developers/docs/resources/channel#embed-object-embed-footer-structure) object added, and can be added to the EmbedBuilder.
- [Image](https://discordapp.com/developers/docs/resources/channel#embed-object-embed-image-structure) object added, and can be added to the EmbedBuilder.
- Added example using all embed objects to [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples) folder.

## [0.1.3] 2018-10-20

### Fixed

- Fixed build slug also causing casing issues on Linux.


## [0.1.2] 2018-10-20

### Fixed

- Fixed casing causing issues on Linux when building and importing.