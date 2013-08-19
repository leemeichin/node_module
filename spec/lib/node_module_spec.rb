require 'spec_helper'

describe NodeModule, "integration into other classes" do

  class ExampleClass
    include NodeModule

    node_module

    def hello_you(*names)
      "hello #{names.join(', ')}"
    end

    def goodbye_you(*names)
      "goodbye #{names.join(', ')}"
    end

    def equal?(a, b)
      a == b
    end

    def not_equal?(a, b)
      ! equal?(a, b)
    end
  end

  let(:example_class) { ExampleClass.new }

  it "says 'hello' to all the people" do
    example_class.hello_you("Sarah", "Jess").must_equal "hello Sarah, Jess"
  end

  it "says 'goodbye' to all the people" do
    example_class.goodbye_you("Tom", "Hayley").must_equal "goodbye Tom, Hayley"
  end

  it "returns true if 1 is not equal to 2" do
    example_class.not_equal?(1, 2).must_equal true
  end
end
