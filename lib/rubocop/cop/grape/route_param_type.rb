# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      class RouteParamType < Base
        MSG = 'Define Parameter Type'

        def_node_matcher :route_param?, <<~RUBY
          (send _ :route_param ({sym str} _) ...)
        RUBY

        def_node_matcher :include_key_type?, <<~RUBY
          (pair (sym :type) _)
        RUBY

        def on_send(node)
          return unless route_param?(node)

          options = node.children.last.children
          return if options.any? { |clild_node| include_key_type?(clild_node) }

          add_offense(node)
        end
      end
    end
  end
end
