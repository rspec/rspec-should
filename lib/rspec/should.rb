# frozen_string_literal: true

# Namespace for all RSpec code.
module RSpec
  # RSpec::Should provides the original  `should` and `should_not` syntax for RSpec >= 4.
  #
  # From the  beginning RSpec provided `should` and `should_not` methods
  # to define expectations on any object. In version 2.11 `expect` method was
  # introduced which became the recommended way to define expectations on an object.
  #
  # ### Why switch over from `should` to `expect`
  #
  # #### Fix edge case issues
  #
  # `should` and `should_not` work by being added to every object. However, RSpec
  # does not own every object and cannot ensure they work consistently on every object.
  # In particular, they can lead to surprising failures when used with BasicObject-subclassed
  # proxy objects.
  #
  # `expect` avoids these problems altogether by not needing to be available on all objects.
  #
  # #### Unification of block and value syntaxes
  #
  # Before version 2.11 `expect` was just a more readable alternative for block
  # expectations. Since version 2.11 `expect` can be used for both block and value
  # expectations.
  #
  # ```ruby
  # expect(actual).to eq(expected)
  # expect { ... }.to raise_error(ErrorClass)
  # ```
  #
  # See [http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax](http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax)
  # For a detailed explanation
  #
  # ## Usage
  # The `should` and `should_not` methods can be used to define expectations on any object.
  #
  # ```ruby
  # actual.should eq expected
  # actual.should be > 3
  # [1, 2, 3].should_not include 4
  # ```
  #
  # ## Using Built-in matchers
  #
  # ### Equivalence
  # ```ruby
  # actual.should     eq(expected)  # passes if actual == expected
  # actual.should     == expected   # passes if actual == expected
  # actual.should_not eql(expected) # passes if actual.eql?(expected)
  # ```
  #
  # Note: we recommend the `eq` matcher over `==` to avoid Ruby's "== in a
  # useless context" warning when the `==` matcher is used anywhere but the
  # last statement of an example.
  #
  # ### Identity
  #
  # ```ruby
  # actual.should     be(expected)    # passes if actual.equal?(expected)
  # actual.should_not equal(expected) # passes if actual.equal?(expected)
  # ```
  #
  # ### Comparisons
  #
  # ```ruby
  # actual.should be >  expected
  # actual.should be >= expected
  # actual.should be <= expected
  # actual.should be <  expected
  # actual.should be_within(delta).of(expected)
  # ```
  #
  # ### Regular expressions
  #
  # ```ruby
  # actual.should match(/expression/)
  # actual.should =~ /expression/
  # ```
  #
  # ### Types/classes
  #
  # ```ruby
  # actual.should     be_an_instance_of(expected)
  # actual.should_not be_a_kind_of(expected)
  # ```
  #
  # ### Truthiness
  #
  # ```ruby
  # actual.should be_true  # passes if actual is truthy (not nil or false)
  # actual.should be_false # passes if actual is falsy (nil or false)
  # actual.should be_nil   # passes if actual is nil
  # ```
  #
  # ### Predicate matchers
  #
  # ```ruby
  # actual.should     be_xxx         # passes if actual.xxx?
  # actual.should_not have_xxx(:arg) # passes if actual.has_xxx?(:arg)
  # ```
  #
  # ### Ranges (Ruby >= 1.9 only)
  #
  # ```ruby
  # (1..10).should cover(3)
  # ```
  #
  # ### Collection membership
  #
  # ```ruby
  # actual.should include(expected)
  # actual.should start_with(expected)
  # actual.should end_with(expected)
  # ```
  #
  # #### Examples
  #
  # ```ruby
  # [1,2,3].should       include(1)
  # [1,2,3].should       include(1, 2)
  # [1,2,3].should       start_with(1)
  # [1,2,3].should       start_with(1,2)
  # [1,2,3].should       end_with(3)
  # [1,2,3].should       end_with(2,3)
  # {:a => 'b'}.should   include(:a => 'b')
  # "this string".should include("is str")
  # "this string".should start_with("this")
  # "this string".should end_with("ring")
  # ```
  module Should
    module_function

    # Enables the `should` syntax on the default host (Object's last ancestor).
    def enable!
      enable_should(default_should_host)
    end

    # @api private
    # Determines where we add `should` and `should_not`.
    def default_should_host
      @default_should_host ||= ::Object.ancestors.last
    end

    # @api private
    # Enables the `should` syntax.
    def enable_should(syntax_host = default_should_host)
      return if should_enabled?(syntax_host)

      syntax_host.module_exec do
        def should(matcher = nil, message = nil, &block)
          ::RSpec::Expectations::PositiveExpectationHandler.handle_matcher(self, matcher, message, &block)
        end

        def should_not(matcher = nil, message = nil, &block)
          ::RSpec::Expectations::NegativeExpectationHandler.handle_matcher(self, matcher, message, &block)
        end
      end
    end

    # @api private
    # Indicates whether or not the `should` syntax is enabled.
    def should_enabled?(syntax_host = default_should_host)
      syntax_host.method_defined?(:should)
    end
  end
end
