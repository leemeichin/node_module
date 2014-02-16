require 'strscan'

module NodeModule
  class Compiled

    def self.inherited(receiver)
      source = File.read(caller.first[/^[^:]+/])

      extract_class_definition(source) do |class_def|
        NodeModule.opal_js_context.compile(class_def)
      end

      receiver.extend NodeModule::ClassMethods

      NodeModule.compile_on_callback(receiver)
    end

    private

    def self.extract_class_definition(source)
      scanner = StringScanner.new(source)
      scanner.scan_until(/^\s+class/)

      indent = scanner.matched[/[^\n]\s+/].length
      scanner.pos = scanner.pos - scanner.matched_size

      definition = scanner.scan_until(/^\s{#{indent}}end/)
                          .sub('< NodeModule::Compiled', '')

      yield definition

    ensure
      scanner.terminate
    end

  end
end
