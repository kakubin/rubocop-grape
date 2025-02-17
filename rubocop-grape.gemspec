# frozen_string_literal: true

require_relative 'lib/rubocop/grape/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop-grape'
  spec.version = RuboCop::Grape::VERSION
  spec.authors = ['Akito Hikasa']
  spec.email = ['wetsand.wfs@gmail.com']

  spec.summary = 'Automatice Grape code style checking tool.'
  spec.description = <<~DESCRIPTION
    Automatic Grape code style checking tool.
    A RuboCop extension focused on enforcing Grape best practices and coding conventions.
  DESCRIPTION

  spec.homepage = 'https://github.com/kakubin/rubocop-grape'
  spec.required_ruby_version = '>= 2.7.0'
  spec.license = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/kakubin/rubocop-grape/blob/master/CHANGELOG.md'
  spec.metadata['default_lint_roller_plugin'] = 'RuboCop::Grape::Plugin'

  spec.files = `git ls-files bin config lib LICENSE.txt README.md`.split($RS)

  spec.add_runtime_dependency 'lint_roller', '~> 1.1'
  spec.add_runtime_dependency 'rubocop', '>= 1.72.1', '< 2'
end
