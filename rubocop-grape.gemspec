# frozen_string_literal: true

require_relative "lib/rubocop/grape/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-grape"
  spec.version = Rubocop::Grape::VERSION
  spec.authors = ["Akito Hikasa"]
  spec.email = ["wetsand.wfs@gmail.com"]

  spec.summary = "Automatice Grape code style checking tool."
  spec.description = <<~DESCRIPTION
    Automatic Grape code style checking tool.
    A RuboCop extension focused on enforcing Grape best practices and coding conventions.
  DESCRIPTION

  spec.homepage = "https://github.com/kakubin/rubocop-grape"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/kakubin/rubocop-grape/blob/master/CHANGELOG.md"

  spec.files = `git ls-files bin config lib LICENSE.txt README.md`.split($RS)

  spec.add_runtime_dependency "rubocop", ">= 1.7.0", "< 2.0"
end
