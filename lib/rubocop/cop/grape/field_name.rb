# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # @example EnforcedStyle: snake_case (default)
      #   # bad
      #   params do
      #     requires :userName
      #     optional :phoneNumber
      #   end
      #
      #   # good
      #   params do
      #     requires :user_name
      #     optional :phone_number
      #   end
      #
      # @example EnforcedStyle: camelCase
      #   # bad
      #   params do
      #     requires :user_name
      #     optional :phone_number
      #   end
      #
      #   # good
      #   params do
      #     requires :userName
      #     optional :phoneNumber
      #   end
      #
      class FieldName < Base
        include ConfigurableNaming
        include RangeHelp

        MSG = 'Use %<style>s for field names.'

        def_node_matcher :params_block?, <<~PATTERN
          (block (send _ :params) _ $_)
        PATTERN

        def_node_matcher :field_name, <<~PATTERN
          (send _ {:requires :optional} (sym $_) ...)
        PATTERN

        def on_block(node)
          return unless (body = params_block?(node))

          if body.type == :begin
            body.children.each(&method(:check_field_name))
          else
            check_field_name(body)
          end
        end

        private

        def check_field_name(node)
          field = node.children[2]
          check_name(node, field_name(node), field.source_range)
        end

        def message(style)
          format(MSG, style: style)
        end
      end
    end
  end
end
