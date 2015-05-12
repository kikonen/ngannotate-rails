require 'active_support/core_ext/class/attribute'
if Ngannotate.sprockets_v3?
  require 'ngannotate/processor3'
else
  require 'ngannotate/processor'
end

module Ngannotate
  module Rails
    class Railtie < ::Rails::Railtie
      config.before_configuration do |app|
        config.ng_annotate = ActiveSupport::OrderedOptions.new
        ng = config.ng_annotate

        # Establish static configuration defaults

        # @see ngannotate
        ng.options = {}

        # Disabled by default in development and test environments
        ng.process = !::Rails.env.development? && !::Rails.env.test?

        # comma separate list of paths to only handle for annotation
        # - ignore_paths entries are filtered out from this
        ng.paths = [/.*/]

        # comma separate list of paths to ignore from annotation
        ng.ignore_paths = [
          '/vendor/',
        ]
      end

      if config.respond_to?(:assets)
        config.assets.configure do |env|
          env.register_postprocessor 'application/javascript', Ngannotate::Processor
        end
      else
        initializer "ngannotate-rails.add_ngannotate_postprocessor", :group => :all do |app|
          app.assets.register_postprocessor 'application/javascript', Ngannotate::Processor
        end
      end
    end
  end
end
