require 'live_ast/to_ruby'
require 'live_ast/irb_spy' if defined?(IRB)

require 'node_module/version'

module NodeModule

  autoload :OpalJsContext, 'node_module/opal_js_context'
  autoload :Compiled, 'node_module/compiled'

  def self.included(receiver)
    receiver.extend ClassMethods
  end

  def self.opal_js_context
    @ctx ||= OpalJsContext.new
  end

  module ClassMethods
    def node_module(*methods)
      if methods.empty?
        NodeModule.compile_on_callback(self)
      else
        NodeModule.compile_and_replace!(self, methods)
      end
    end
  end

  def self.compile_and_replace!(receiver, methods)
    methods.each do |name|
      meth = receiver.instance_method(name).to_ruby
      self.opal_js_context.compile(meth)
      self.replace_method!(receiver, name)
    end
  end

  def self.compile_on_callback(receiver)
    active = nil
    receiver.define_singleton_method(:method_added) do |name|
      return if active
      active = true
      receiver.node_module(name)
      active = false
    end
  end

  def self.replace_method!(receiver, name)
    receiver.send :define_method, name do |*args|
      NodeModule.opal_js_context.run(__method__, args)
    end
  end

end
