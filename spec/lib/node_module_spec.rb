require 'spec_helper'

describe NodeModule do

  class TestClass
    include NodeModule

    node_module

    def hello_you(*names)
      "hello #{names.join(', ')}"
    end
  end

  describe "#hello_you" do
    let(:test_class) { TestClass.new }

    it "should say 'hello' to all the people" do
      test_class.hello_you("Sarah", "Jess").must_equal "hello Sarah, Jess"
    end
  end
end
