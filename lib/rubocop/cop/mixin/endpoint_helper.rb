# frozen_string_literal: true

module RuboCop
  module Cop
    # EndpointHelper is a set of AST definitions for endpoint definition by Grape DSL
    module EndpointHelper
      extend NodePattern::Macros

      def_node_matcher :http_method_node?, <<~PATTERN
        (block (send _ {:get :post :put :patch :delete} ...) ...)
      PATTERN

      def_node_matcher :params_node?, <<~PATTERN
        (block (send _ :params) _ $_)
      PATTERN
    end
  end
end
