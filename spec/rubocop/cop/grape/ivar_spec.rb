# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::Ivar, :config do
  context 'if ivars were used' do
    it 'registers an offense' do
      expect_offense(<<~RUBY)
        @user = User.new
        ^^^^^^^^^^^^^^^^ Don't use instance_variable
      RUBY
    end

    it 'registers an offense' do
      expect_offense(<<~RUBY)
        ActiveRecord.with_readonly do
          @user = User.new
          ^^^^^^^^^^^^^^^^ Don't use instance_variable
        end
      RUBY
    end
  end

  context 'if ivars were not used' do
    it 'will report no offenses' do
      expect_no_offenses(<<~RUBY)
        user = User.new
      RUBY
    end
  end
end
