# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/).
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] 2024-06-08
### Fixed
- Can now send minimal embeds without issue
- Cleaned up / modernized Pester tests

### Added
- You can now send a timestamp

## [0.2.1] 2019-12-24

### Fixed
- Bugfix for a bug brought to light by a new version of PowerShell Core. ContentType for Invoke-RestMethod is now set to 'Application/Json', and not an unset variable (whoops)

## [0.2.0] 2019-04-29

### Added
- Changed the configuration creation parameter '[CreateConfig](https://github.com/gngrninja/PSDsHook/blob/master/PSDsHook/functions/public/Invoke-PsDsHook.ps1)' to a string, and the argument to the value of the webhook URL. Updated [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples)/help to reflect this change.
- Changed the position of EmbedObject to 0. This allows you to pass embeds in without needing to use the parameter explicitly, and thus increase fluidity.
- Updated [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples) and [documentation](https://github.com/gngrninja/PSDsHook/tree/master/docs), as well as README to reflect the changes made.

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