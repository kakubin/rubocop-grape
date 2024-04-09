# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::RouteParamGrouping, :config do
  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      route_param :id, type: Integer do
        get do
        end
      end
    RUBY
  end

  context 'without other options' do
    it 'offense detected' do
      expect_offense(<<~RUBY)
        get ':id' do
            ^^^^^ Use route_param for route parameters
        end
      RUBY
    end
  end

  context 'with other options' do
    it 'offense detected' do
      expect_offense(<<~RUBY)
        get ':id', requirements: { id: /[0-9]*/ }  do
            ^^^^^ Use route_param for route parameters
        end
      RUBY
    end
  end

  context 'ss' do
    it 'offense detected' do
      expect_offense(<<~RUBY)
        get 'books/:id' do
            ^^^^^^^^^^^ Use route_param for route parameters
        end
      RUBY
    end
  end
end
