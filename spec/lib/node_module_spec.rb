require 'spec_helper'

describe NodeModule do

  class TestClass
    include NodeModule

    node_module

    def hello_you(*names)
      "hello #{names.join(', ')}"
    end
  end



  describe "integration" do
    let(:test_class) { TestClass.new }

    it "says 'hello' to all the people" do
      test_class.hello_you("Sarah", "Jess").must_equal "hello Sarah, Jess"
    end
  end

  describe "#convert_method_to_javascript" do
    let(:test_method) { "def equal?(a, b); a == b; end;" }

    it "successfully turns Ruby into Opal-style Javascript" do
      js = NodeModule.convert_method_to_javascript(test_method)
      js.to_s.must_match /function \(a, b\) \{\s+ return a\['\$=='\]\(b\);\s+\}/
    end
  end

  describe "#call_javascript_function" do
    let(:predicate_method) { "def equal?(a, b); a == b; end;" }
    let(:bang_method) { "def boom!; 'BOOM!'; end;" }
    let(:mixed_method) { "def boom?(a, b); boom! if a == b; end;" }

    before do
      NodeModule.convert_method_to_javascript(predicate_method)
      NodeModule.convert_method_to_javascript(bang_method)
      NodeModule.convert_method_to_javascript(mixed_method)
    end

    it "handles Ruby style predicate methods" do
      result = NodeModule.call_javascript_function('equal?', [1, 1])
      result.must_equal true

      result = NodeModule.call_javascript_function('equal?', [1, 2])
      result.must_equal false
    end

    it "handles Ruby style bang methods" do
      result = NodeModule.call_javascript_function('boom!')
      result.must_equal 'BOOM!'
    end

    it "can refer to previously defined methods from within a method" do
      result = NodeModule.call_javascript_function('boom?', [1, 1])
      result.must_equal 'BOOM!'
    end
  end

end
