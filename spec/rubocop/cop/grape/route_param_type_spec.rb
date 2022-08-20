# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::RouteParamType, :config do
  context 'if param type defined' do
    it 'no offence reported' do
      expect_no_offenses('route_param :id, type: Integer')
    end
  end

  context 'if param type not defined' do
    context 'with no any other options' do
      it 'offence detected' do
        expect_offense(<<~RUBY)
          route_param :id do
          ^^^^^^^^^^^^^^^
        RUBY
      end
    end

    context 'with several options' do
      it 'offence detected' do
        expect_offense(<<~RUBY)
          route_param :id, desc: 'ID' do
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
        RUBY
      end
    end
  end
end
