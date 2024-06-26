# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      #
      # @example
      #   # bad
      #   get do
      #     params do
      #       requires :user_id, Integer, desc: 'User ID'
      #     end
      #   end
      #
      #   # good
      #   params do
      #     requires :user_id, Integer, desc: 'User ID'
      #   end
      #   get do
      #   end
      #
      class ParamsPosition < Base
        include EndpointHelper

        MSG = "It's no sense to define params in HTTP method's scope"

        def on_block(node)
          return unless http_method_node?(node)

          collect_violating_nodes(node).each(&method(:add_offense))
        end

        def collect_violating_nodes(node, collector = [])
          collector.push(node) if node.type == :block && params_node?(node)

          node.children.each do |descendant|
            collect_violating_nodes(descendant, collector) if descendant.is_a?(Parser::AST::Node)
          end

          collector
        end
      end
    end
  end
end
