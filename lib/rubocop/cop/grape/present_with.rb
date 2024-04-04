# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # @example
      #
      #   # bad
      #   get do
      #     present users: users, with: API::Entities::User
      #   end
      #
      #   # good
      #   get do
      #     present :users, users, with: API::Entities::User
      #   end
      #
      class PresentWith < Base
        extend AutoCorrector
        include EndpointHelper

        MSG_TEMPLATE = 'Maybe you mistyped "`%<current>s`", it should be "`%<correct>s`"'

        def_node_matcher :one_hash_arg_with_key_name_with?, <<~PATTERN
          (send _ :present
            (hash
              (pair (sym $_key)
                {(send _ $_val) (lvar $_val)})
              (pair (sym :with) _)))
        PATTERN

        def on_send(present_node)
          one_hash_arg_with_key_name_with?(present_node) do |key, val|
            kwarg = present_node.children.last

            add_offense(kwarg.children.first, message: message(key, val)) do |corrector|
              corrector.remove(kwarg.children.first)
              corrector.insert_before(kwarg, ":#{key}, #{val}")
            end
          end
        end

        def message(key, val)
          format(MSG_TEMPLATE, current: "#{key}: #{val}", correct: ":#{key}, #{val}")
        end
      end
    end
  end
end
