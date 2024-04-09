# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      #
      # @example
      #
      #   # bad
      #   get ':id' do
      #   end
      #
      #   # good
      #   route_param :id, type: Integer do
      #     get do
      #     end
      #   end
      #
      class RouteParamGrouping < Base
        include EndpointHelper

        MSG = 'Use route_param for route parameter'

        def on_block(node)
          return unless (method_send_node = http_method_node?(node))
          return unless (first_argument_node = method_send_node.arguments.first)
          return unless first_argument_node.value.match?(/:\w/)

          add_offense(first_argument_node)
        end
      end
    end
  end
end
