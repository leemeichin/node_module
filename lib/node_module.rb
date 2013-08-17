require "node_module/version"
require 'live_ast/to_ruby'
require 'opal'
require 'v8'

module NodeModule

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def node_module(*methods)
      if methods.empty?
        NodeModule.execute_following_methods_as_javascript!(self)
      else
        NodeModule.execute_methods_as_javascript!(methods, self)
      end
    end
  end

  module_function

  def self.eval_js(function, passed_args)
    @ctx ||= V8::Context.new do |ctx|
      ctx.eval Opal::Builder.build('opal')
    end

    @ctx.eval Opal.parse(function)
  end

  def self.execute_methods_as_javascript!(methods, receiver)
    methods.each do |name|
      function = receiver.method(name).to_ruby

      receiver.send :define_method, name do |*passed_args|
        NodeModule.eval_js(function, passed_args)
      end
    end
  end

  def self.execute_following_methods_as_javascript!(receiver)
    active = nil
    receiver.define_singleton_method(:method_added) do |meth_name|
      return if active
      active = true
      receiver.node_module(meth_name)
      active = false
    end
  end

end
