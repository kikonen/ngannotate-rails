require 'active_support/core_ext/class/attribute'
require 'ngannotate/processor'

module Ngannotate
  module Rails
    class Railtie < ::Rails::Railtie
      ng = config.ng_annotate = ActiveSupport::OrderedOptions.new

      # Establish static configuration defaults

      # @see ngannotate
      ng.options = {}

      # @see ngannotate
      ng.regexp = nil

      # Disabled by default in development and test environments
      ng.process = !::Rails.env.development? && !::Rails.env.test?

      # comma separate list of paths to ignore from annotation
      ng.ignore_paths = [
        '/vendor/',
      ]

      initializer "ngannotate-rails.add_ngannotate_postprocessor", :group => :all do |app|
        app.assets.register_postprocessor 'application/javascript', Ngannotate::Processor
      end
    end
  end
end
