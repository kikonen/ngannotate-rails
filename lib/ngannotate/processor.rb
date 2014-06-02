require 'sprockets/processor'

module Ngannotate
  class Processor < Sprockets::Processor
    def self.name
      'Ngannotate::Processor'
    end

    def prepare
      return if skip
      ngannotate_source = File.open(File.join(File.dirname(__FILE__), '../../vendor/ngannotate.js')).read
      @context = ExecJS.compile "window = {};" + ngannotate_source
    end

    #
    # Skip processing in environments where it does not make sense
    #
    def skip
      ::Rails.env.development? || ::Rails.env.test?
    end

    def evaluate(context, locals)
      return data if skip

      opt = { add: true }.merge!(parse_opt)
      r = @context.call 'window.annotate', data, opt
      r['src']
    end

    def parse_opt
      opt = {}
      opt_str = ENV['NG_OPT']
      if opt_str
        opt = Hash[opt_str.split(',').map { |e| e.split('=') }]
        opt.symbolize_keys!
      end
      if ENV['NG_REGEXP']
        opt[:regexp] = ENV['NG_REGEXP']
      end
      opt
    end
  end
end
