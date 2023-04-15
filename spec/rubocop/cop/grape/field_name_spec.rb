# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::FieldName, :config do
  let(:cop_config) { { 'EnforcedStyle' => enforced_style } }

  context 'snake_case' do
    let(:enforced_style) { 'snake_case' }

    it 'allow snake_case when snake_case are registered as enforced_style' do
      expect_no_offenses(<<~RUBY)
        params do
          requires :user_name, type: String
        end
      RUBY
    end

    it 'allow snake_case on nested field when snake_case are registered as enforced_style' do
      expect_no_offenses(<<~RUBY)
        params do
          requires :user, type: Hash do
            requires :phone_number, type: String
          end
        end
      RUBY
    end

    it 'registers an offense when using camelCase on field' do
      expect_offense(<<~RUBY)
        params do
          requires :userName, type: String
                   ^^^^^^^^^ Use snake_case for field names.
        end
      RUBY
    end

    it 'registers two offenses when using camelCase on field' do
      expect_offense(<<~RUBY)
        params do
          requires :userName, type: String
                   ^^^^^^^^^ Use snake_case for field names.
          optional :phoneNumber, type: String
                   ^^^^^^^^^^^^ Use snake_case for field names.
        end
      RUBY
    end

    it 'registers a offense when using camelCase on field which has children' do
      expect_offense(<<~RUBY)
        params do
          requires :userProfile, type: Hash do
                   ^^^^^^^^^^^^ Use snake_case for field names.
            requires :name, type: String
          end
        end
      RUBY
    end

    it 'registers a offense when using camelCase on a child field' do
      expect_offense(<<~RUBY)
        params do
          requires :user, type: Hash do
            requires :phoneNumber, type: String
                     ^^^^^^^^^^^^ Use snake_case for field names.
          end
        end
      RUBY
    end

    it 'never consider definitions other than requires and optional' do
      expect_no_offenses(<<~RUBY)
        params do
          optional :login_id, type: String
          optional :email_address, type: String
          at_least_one_of :login_id, :email_address
        end
      RUBY
    end
  end

  context 'camelCase' do
    let(:enforced_style) { :camelCase }

    it 'allow camelCase when camelCase are registered as enforced_style' do
      expect_no_offenses(<<~RUBY)
        params do
          requires :userName, type: String
        end
      RUBY
    end

    it 'registers an offense when using snake_case on field' do
      expect_offense(<<~RUBY)
        params do
          optional :user_name, type: String
                   ^^^^^^^^^^ Use camelCase for field names.
        end
      RUBY
    end

    it 'registers two offenses when using snake_case on field' do
      expect_offense(<<~RUBY)
        params do
          requires :user_name, type: String
                   ^^^^^^^^^^ Use camelCase for field names.
          requires :phone_number, type: String
                   ^^^^^^^^^^^^^ Use camelCase for field names.
        end
      RUBY
    end
  end
end
