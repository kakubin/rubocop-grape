# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::RouteParamType, :config do
  context 'if param type defined' do
    context 'without other options' do
      it 'no offence reported' do
        expect_no_offenses(<<~RUBY)
          route_param :id, type: Integer
        RUBY
      end
    end

    context 'with other options' do
      it 'no offence reported' do
        expect_no_offenses(<<~RUBY)
          route_param :id, type: Integer, desc: 'ID'
        RUBY
      end
    end
  end

  context 'if param type not defined' do
    context 'with other options' do
      it 'offence detected' do
        expect_offense(<<~RUBY)
          route_param :id
          ^^^^^^^^^^^^^^^ Define Parameter Type
        RUBY
      end
    end

    context 'with other options' do
      it 'offence detected' do
        expect_offense(<<~RUBY)
          route_param :id, desc: 'ID'
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Define Parameter Type
        RUBY
      end
    end
  end
end
