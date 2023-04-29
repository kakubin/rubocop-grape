# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Grape::AbcSize, :config do
  context 'when Max is 0' do
    let(:cop_config) { { 'Max' => 0 } }

    it 'accepts an empty endpoint' do
      expect_no_offenses(<<~RUBY)
        get do
        end
      RUBY
    end

    it 'accepts an empty named endpoint' do
      expect_no_offenses(<<~RUBY)
        get :endpoint do
        end
      RUBY
    end

    it 'registers an offense for an if modifier' do
      expect_offense(<<~RUBY)
        get do
        ^^^^^^ Assignment Branch Condition size is too high. [<0, 2, 1> 2/0]
          call_foo if some_condition # 0 + 2*2 + 1*1
        end
      RUBY
    end

    it 'registers an offense for an assignment of a local variable' do
      expect_offense(<<~RUBY)
        get do
        ^^^^^^ Assignment Branch Condition size is too high. [<1, 0, 0> 1/0]
          x = 1
        end
      RUBY
    end

    it 'registers an offense for an assignment of an element' do
      expect_offense(<<~RUBY)
        get do
        ^^^^^^ Assignment Branch Condition size is too high. [<1, 2, 0> 2/0]
          x[0] = 1
        end
      RUBY
    end

    it 'registers an offense for complex content including A, B, and C scores' do
      expect_offense(<<~RUBY)
        get do
        ^^^^^^ Assignment Branch Condition size is too high. [<3, 4, 5> 7/0]
          my_options = Hash.new if 1 == 1 || 2 == 2 # 1, 1, 4
          my_options.each do |key, value|           # 2, 1, 1
            p key                                   # 0, 1, 0
            p value                                 # 0, 1, 0
          end
        end
      RUBY
    end

    it 'treats safe navigation method calls like regular method calls + a condition' do
      expect_offense(<<~RUBY)
        get do
        ^^^^^^ Assignment Branch Condition size is too high. [<0, 2, 1> 2/0]
          object&.do_something
        end
      RUBY
    end

    context 'when CountRepeatedAttributes is `false`' do
      let(:cop_config) { { 'Max' => 0, 'CountRepeatedAttributes' => false } }

      it 'does not count repeated attributes' do
        expect_offense(<<~RUBY)
          get do
          ^^^^^^ Assignment Branch Condition size is too high. [<0, 1, 0> 1/0]
            bar
            self.bar
            bar
          end
        RUBY
      end
    end

    context 'when CountRepeatedAttributes is `true`' do
      let(:cop_config) { { 'Max' => 0, 'CountRepeatedAttributes' => true } }

      it 'counts repeated attributes' do
        expect_offense(<<~RUBY)
          get do
          ^^^^^^ Assignment Branch Condition size is too high. [<0, 3, 0> 3/0]
            bar
            self.bar
            bar
          end
        RUBY
      end
    end
  end

  context 'when Max is 2' do
    let(:cop_config) { { 'Max' => 2 } }

    it 'accepts two assignments' do
      expect_no_offenses(<<~RUBY)
        get do
          x = 1
          y = 2
        end
      RUBY
    end
  end
end
