# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::ParamsPosition, :config do
  context 'if params declared on exact position' do
    it 'will report no offences' do
      expect_no_offenses(<<~RUBY)
        params do
          requires :user_id, type: Integer
        end
        get do
          User.find(params[:user_id])
        end
      RUBY
    end
  end

  context 'if params not defined' do
    it 'will reports no offences' do
      expect_no_offenses(<<~RUBY)
        get do
          User.find(params[:user_id])
        end
      RUBY
    end
  end

  context 'if params declared on wrong position' do
    it 'reports a offence' do
      expect_offense(<<~RUBY)
        get do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offence even though deep nested' do
      expect_offense(<<~RUBY)
        get do
          Rails.log.info 'Process Start'
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports two offences' do
      expect_offense(<<~RUBY)
        get do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end

          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :order, type: String
          end
        end
      RUBY
    end

    it 'reports a offence on named endpoint' do
      expect_offense(<<~RUBY)
        get :index do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offence on post method' do
      expect_offense(<<~RUBY)
        post do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offence on put method' do
      expect_offense(<<~RUBY)
        put do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offence on patch method' do
      expect_offense(<<~RUBY)
        patch do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offence on delete method' do
      expect_offense(<<~RUBY)
        delete do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end
  end
end
