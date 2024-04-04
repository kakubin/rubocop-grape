# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::PresentWith, :config do
  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      get do
        present users
      end
    RUBY
  end

  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      get do
        present users: users
      end
    RUBY
  end

  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      get do
        present users: users, posts: posts
      end
    RUBY
  end

  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      get do
        present :users, users, with: API::Entities::User
      end
    RUBY
  end

  it 'no offense reported' do
    expect_no_offenses(<<~RUBY)
      get do
        present :users, users
      end
    RUBY
  end

  it 'offense detected' do
    expect_offense(<<~RUBY)
      get do
        users = User.all
        present users: users, with: API::Entities::User
                ^^^^^^^^^^^^ Maybe you mistyped "`users: users`", it should be "`:users, users`"
      end
    RUBY
  end
end
