# frozen_string_literal: true

require 'lint_roller'

module RuboCop
  module Grape
    # A plugin that integrates RuboCop Grape with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      # :nocov:
      def about
        LintRoller::About.new(
          name: 'rubocop-grape',
          version: VERSION,
          homepage: 'https://github.com/kakubin/rubocop-grape',
          description: 'Code style checking for Grape files.'
        )
      end

      # :nocov:
      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        project_root = Pathname.new(__dir__).join('../../..')
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: project_root.join('config/default.yml')
        )
      end
    end
  end
end
