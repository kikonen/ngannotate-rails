require 'execjs'
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
    # To allow testing assets compile in development environment
    #
    # To explicitly force assets compile in development environment
    #  NG_FORCE=true RAILS_ENV=development bundle exec rake assets:clean assets:precompile
    # or add to environments/development.rb
    #  config.ng_annotate.process = true
    #
    def force
      ENV['NG_FORCE'] == 'true'
    end

    #
    # Skip processing in environments where it does not make sense.
    # Override by NG_FORCE=true env variable
    #
    def skip
      !force && !::Rails.configuration.ng_annotate.process
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
