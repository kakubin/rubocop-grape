# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/grape'
require_relative 'rubocop/grape/version'
require_relative 'rubocop/grape/inject'

RuboCop::Grape::Inject.defaults!

require_relative 'rubocop/cop/grape_cops'
