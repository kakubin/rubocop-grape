# RuboCop Grape

[![Actions Status](https://github.com/kakubin/rubocop-grape/workflows/Ruby/badge.svg?branch=main)](https://github.com/kakubin/rubocop-grape/actions?query=workflow%3ARuby)

[RuboCop](https://github.com/rubocop/rubocop) extension for [Grape](https://rubygems.org/gems/grape/versions/0.16.2).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-grape'
```

And then execute:

    $ bundle install

## Usage

You need to tell RuboCop to load the Grape extension. There are three
ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-grape
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-grape
```

Now you can run `rubocop` and it will automatically load the RuboCop Grape
cops together with the standard cops.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakubin/rubocop-grape.
