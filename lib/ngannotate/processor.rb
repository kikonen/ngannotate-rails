require 'sprockets/processor'

module Ngannotate
  class Processor < Sprockets::Processor
    def self.name
      'Ngannotate::Processor'
    end

    def prepare
      ngannotate_source = File.open(File.join(File.dirname(__FILE__), '../../vendor/ngannotate.js')).read
      @context = ExecJS.compile "window = {};" + ngannotate_source
    end

    def evaluate(context, locals)
      r = @context.call 'window.annotate', data, { add: true }
      r['src']
    end
  end
end
