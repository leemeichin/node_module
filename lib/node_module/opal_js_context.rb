require 'v8'
require 'json'
require 'opal'

class NodeModule::OpalJsContext < V8::Context

  def initialize
    super do |ctx|
      ctx.eval Opal::Builder.build('opal')
    end
  end

  def compile(code)
    eval Opal.parse(code)
  end

  def run(name, args=[])
    eval <<-JS
      Opal.Object['$#{name}'].apply(Opal.Object, #{args.to_json})
    JS
  end

end
