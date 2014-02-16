require 'spec_helper'

describe NodeModule::Compiled, "run entire class against V8" do

  class Greeter < NodeModule::Compiled

    def initialize(*names)
      @names = names
    end

    def hello!
      @names.map {|name| "hello #{name}!" }.join(" ")
    end

    def goodbye!
      hello!.gsub('hello', 'goodbye')
    end

  end

  describe "integration with the subclass" do

    let(:greeter) { Greeter.new("Sarah", "Jess") }

    it "says 'hello' to all the people" do
      greeter.hello!.must_equal "hello Sarah! hello Jess!"
    end

    it "says 'goodbye' to all the people" do
      greeter.goodbye!.must_equal "goodbye Sarah! goodbye Jess!"
    end

  end

end
