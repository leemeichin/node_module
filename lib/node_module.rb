require 'node_module/version'
require 'live_ast/to_ruby'
require 'live_ast/irb_spy' if defined?(IRB)

module NodeModule

  autoload :OpalJsContext, 'node_module/opal_js_context'

  def self.included(base)
    base.extend ClassMethods
  end

  def self.opal_js_context
    @ctx ||= OpalJsContext.new
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

      NodeModule.opal_js_context.compile(meth)

      receiver.send :define_method, name do |*args|
        NodeModule.opal_js_context.run(__method__, args)
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
