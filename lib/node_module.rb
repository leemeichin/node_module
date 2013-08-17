require "node_module/version"
require 'live_ast/to_ruby'
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

  def self.eval_js(js)
    @js_ctx ||= V8::Context.new
    @js_ctx.eval(js)
  end

  def self.execute_methods_as_javascript!(methods, receiver)
    methods.each do |name|
      meth = receiver.instance_method(name)
      body = meth.to_ruby.split[2..-1].join

      remove_method(meth)

      receiver.define_method(name) do
        NodeModule.eval_js(body)
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
