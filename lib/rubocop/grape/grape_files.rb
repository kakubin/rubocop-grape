# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # This is a monkey patch for RuboCop
      # which makes rubocop-grape cops adapted only for grape files.
      module GrapeFile
        DEFAULT_GRAPE_DIR = 'app/api'

        def grape_dir
          @grape_dir ||= load_grape_file_from_config || DEFAULT_GRAPE_DIR
        end

        def grape_files
          @grape_files ||= Dir.glob('**/*.rb', base: grape_dir).map do |relative_path|
            File.absolute_path(relative_path, grape_dir)
          end
        end

        Team.prepend self

        private

        def load_grape_file_from_config
          @config.for_all_cops['GrapeDir']
        end

        def roundup_relevant_cops(processed_source)
          super.select do |cop|
            next true unless cop.class.name.match?(/RuboCop::Cop::Grape::.+$/)

            grape_files.include?(processed_source.path)
          end
        end
      end
    end
  end
end
