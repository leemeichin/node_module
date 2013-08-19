require 'spec_helper'

describe NodeModule::OpalJsContext do

  subject { NodeModule::OpalJsContext.new }

  let(:predicate_method) { "def equal?(a, b); a == b; end;" }
  let(:bang_method) { "def boom!; 'BOOM!'; end;" }
  let(:mixed_method) { "def boom?(a, b); boom! if a == b; end;" }

  describe "#load" do
    it "successfully turns Ruby into Opal-style Javascript" do
      js = subject.compile(predicate_method)
      js.to_s.must_match /function \(a, b\) \{\s+ return a\['\$=='\]\(b\);\s+\}/
    end
  end

  describe "#run" do
    before do
      subject.compile(predicate_method)
      subject.compile(bang_method)
      subject.compile(mixed_method)
    end

    it "handles Ruby style predicate methods" do
      result = subject.run('equal?', [1, 1])
      result.must_equal true

      result = subject.run('equal?', [1, 2])
      result.must_equal false
    end

    it "handles Ruby style bang methods" do
      result = subject.run('boom!')
      result.must_equal 'BOOM!'
    end

    it "can refer to previously defined methods from within a method" do
      result = subject.run('boom?', [1, 1])
      result.must_equal 'BOOM!'
    end
  end

end
