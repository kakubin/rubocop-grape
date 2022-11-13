# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::ParamsPosition, :config do
  context 'if params declared on exact position' do
    it 'will report no offenses' do
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
    it 'will reports no offenses' do
      expect_no_offenses(<<~RUBY)
        get do
          User.find(params[:user_id])
        end
      RUBY
    end
  end

  context 'if params declared on wrong position' do
    it 'reports a offense' do
      expect_offense(<<~RUBY)
        get do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offense even though deep nested' do
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

    it 'reports two offenses' do
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

    it 'reports a offense on named endpoint' do
      expect_offense(<<~RUBY)
        get :index do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offense on post method' do
      expect_offense(<<~RUBY)
        post do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offense on put method' do
      expect_offense(<<~RUBY)
        put do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offense on patch method' do
      expect_offense(<<~RUBY)
        patch do
          params do
          ^^^^^^^^^ It's no sense to define params in HTTP method's scope
            requires :id, type: Integer
          end
        end
      RUBY
    end

    it 'reports a offense on delete method' do
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
