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
      opt = { add: true }.merge(parse_opt)
      r = @context.call 'window.annotate', data, opt
      r['src']
    end

    def parse_opt
      opt = {}
      opt_str = ENV['NG_OPT']
      if opt_str
        opt = Hash[opt_str.split(',').map { |e| e.split('=') }]
      end
      opt
    end
  end
end
