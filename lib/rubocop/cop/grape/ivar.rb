# frozen_string_literal: true

module RuboCop
  module Cop
    module Grape
      # @example
      #   # bad
      #   ActiveRecord.with_readonly do
      #     @ivar = User.find(params[:user_id])
      #   end
      #
      #   # good
      #   var = ActiveRecord.with_readonly do
      #     User.find(params[:user_id]
      #   end
      #
      #   # good
      #   office = nil
      #   user = nil
      #
      #   ActiveRecord.with_readonly do
      #     user = User.find(params[:user_id])
      #     office = user.office
      #   end
      #
      class Ivar < Base
        MSG = "Don't use instance_variable"

        def on_ivasgn(node)
          add_offense(node)
        end
      end
    end
  end
end
