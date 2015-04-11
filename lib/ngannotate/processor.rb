require 'execjs'
require 'sprockets/processor'

module Ngannotate
  class Processor < Sprockets::Processor
    def self.name
      'Ngannotate::Processor'
    end

    def prepare
      return unless need_process?
      @exec_context = self.class.shared_exec_context
    end

    def evaluate(context, locals)
      state = need_process? ? :process : (ignore_file? ? :ignore : :skip)
      ::Rails.logger.info "ng-#{state}: #{@file}"
      return data unless need_process?

      opt = { add: true }.merge!(parse_ngannotate_options)
      r = @exec_context.call 'window.annotate', data, opt
      r['src']
    end

    private

    def self.shared_exec_context
      @shared_exec_context ||=
        begin
          ::Rails.logger.info "ng-prepare"
          ngannotate_source = File.open(File.expand_path('../../../vendor/ngannotate.js', __FILE__)).read
          ExecJS.compile "window = {};" + ngannotate_source
        end
    end

    #
    # Is processing done for current file. This is determined by 3 checks
    #
    # - config.ignore_paths
    # - config.process
    # - NG_FORCE=true env option
    #
    def need_process?
      force_process = ENV['NG_FORCE'] == 'true'
      !ignore_file? && (force_process || config.process)
    end

    def config
      ::Rails.configuration.ng_annotate
    end

    #
    # @return true if current file is ignored
    #
    def ignore_file?
      ignore_paths.any? { |p| @file.index(p) }
    end

    def ignore_paths
      @ignore_paths ||= config.ignore_paths.split
    end

    #
    # Parse extra options for ngannotate
    #
    def parse_ngannotate_options
      opt = {}

      opt_str = ENV['NG_OPT'] || config.options
      if opt_str
        opt = Hash[opt_str.split(',').map { |e| e.split('=') }]
        opt.symbolize_keys!
      end

      regexp = ENV['NG_REGEXP'] || config.regexp
      if regexp
        opt[:regexp] = regexp
      end

      opt
    end
  end
end
