require 'node_module/version'
require 'live_ast/to_ruby'
require 'live_ast/irb_spy' if defined?(IRB)
require 'opal'
require 'json'
require 'v8'

module NodeModule

  def self.included(base)
    base.extend ClassMethods
  end

  def self.js_context
    @ctx ||= V8::Context.new do |ctx|
      ctx.eval Opal::Builder.build('opal')
    end
  end

  def self.convert_method_to_javascript(fn)
    NodeModule.js_context.eval Opal.parse(fn)
  end

  def self.call_javascript_function(name, args = [])
    # methods are all defined on Object, as they're parsed and
    # evaluated outside of the context of their original class
    NodeModule.js_context.eval <<-JS
      Opal.Object['$#{name}'].apply(Opal.Object, #{args.to_json})
    JS
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

  def self.execute_methods_as_javascript!(methods, receiver)
    methods.each do |name|
      meth = receiver.instance_method(name).to_ruby
      NodeModule.convert_method_to_javascript(meth)

      receiver.send :define_method, name do |*args|
        NodeModule.call_javascript_function(__method__, args)
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
