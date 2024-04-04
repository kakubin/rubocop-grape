## [Unreleased]

### Changes
* Support Ruby 3.3. ([@kakubin][])
* New cop `Grape/PresentWith` checks mistyped argument on `present` method ([@kakubin][])

## [0.4.0] - 2023-04-29

### New Features
* New cop `Grape/AbcSize` checks the ABC metric, based on assignments, branches, and conditions. ([@kakubin][])


## [0.3.0] - 2023-04-15

### New Features
* New cop `Grape/FieldName` checks that all fields use the configured style. ([@kakubin][])


## [0.2.0] - 2022-11-13

### New Features
* [#10](https://github.com/kakubin/rubocop-grape/pull/10): add new cop Grape/Ivar. ([@kakubin][])

### Changes
* [#9](https://github.com/kakubin/rubocop-grape/pull/9): Docs. ([@kakubin][])
* [#11](https://github.com/kakubin/rubocop-grape/pull/11): s/offence/offense. ([@kakubin][])

### Bug fixes
* [#8](https://github.com/kakubin/rubocop-grape/pull/8): bugfix: match named endpoint definition for Grape/ParamsPosition. ([@kakubin][])

## [0.1.2] - 2022-08-21

### Bug fixes
* [#6](https://github.com/kakubin/rubocop-grape/pull/6): fix typo. ([@kakubin][])
* [#7](https://github.com/kakubin/rubocop-grape/pull/7): support other methods on Grape/ParamsPosition. ([@kakubin][])


## [0.1.1] - 2022-08-21

### New Features
* [#2](https://github.com/kakubin/rubocop-grape/pull/2): add new cop `Grape/ParamsPosition`. ([@kakubin][])

### Changes
* [#3](https://github.com/kakubin/rubocop-grape/pull/3): support ruby from 2.6 to 3.1. ([@kakubin][])
* [#4](https://github.com/kakubin/rubocop-grape/pull/4): fix heredoc name from `RUBY` to `PATTERN`. ([@kakubin][])


## [0.1.0] - 2022-07-13

- Initial release

[@kakubin]: https://github.com/kakubin
