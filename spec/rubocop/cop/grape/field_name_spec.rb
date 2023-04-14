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
