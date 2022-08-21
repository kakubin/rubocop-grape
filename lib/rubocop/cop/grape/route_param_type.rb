# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # Checks whether type is specified at points where `Grape::API#route_param` is called.
      #
      # @example
      #
      #   # bad
      #   route_param :id
      #
      #   # good
      #   route_param :id, type: Integer
      #   route_param :filename, type: String
      #   route_param :status, type: String, desc: 'Resource Status'
      #
      class RouteParamType < Base
        MSG = 'Define Parameter Type'

        def_node_matcher :route_param?, <<~PATTERN
          (send _ :route_param ({sym str} _) ...)
        PATTERN

        def_node_matcher :include_key_type?, <<~PATTERN
          (pair (sym :type) _)
        PATTERN

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
