# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # Checks that the ABC size of endpoints is not higher than the
      # configured maximum. The ABC size is based on assignments, branches
      # (method calls), and conditions. See http://c2.com/cgi/wiki?AbcMetric
      # and https://en.wikipedia.org/wiki/ABC_Software_Metric.
      class AbcSize < Base
        extend ExcludeLimit

        exclude_limit 'Max'

        MSG = 'Assignment Branch Condition size is too high. [%<abc_vector>s %<complexity>d/%<max>d]'

        def_node_matcher :http_method_node?, <<~PATTERN
          (block (send _ {:get :post :put :patch :delete} ...) ...)
        PATTERN

        def on_block(node)
          return unless http_method_node?(node)

          check_complexity(node)
        end

        def check_complexity(node)
          return unless node.body

          max = cop_config['Max']
          complexity, abc_vector = complexity(node.body)
          return unless complexity > max

          msg = format(self.class::MSG, abc_vector: abc_vector, complexity: complexity, max: max)
          add_offense(node, message: msg) { self.max = complexity.ceil }
        end

        def complexity(node)
          Metrics::Utils::AbcSizeCalculator.calculate(
            node,
            discount_repeated_attributes: !cop_config['CountRepeatedAttributes']
          )
        end
      end
    end
  end
end
