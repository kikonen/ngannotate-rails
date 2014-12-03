require 'active_support/core_ext/class/attribute'
require 'ngannotate/processor'

module Ngannotate
  module Rails
    class Railtie < ::Rails::Railtie
      config.ng_annotate = ActiveSupport::OrderedOptions.new

      # Establish static configuration defaults
      # Disabled by default in development and test environments
      config.ng_annotate.process = !::Rails.env.development? && !::Rails.env.test?

      initializer "ngannotate-rails.add_ngannotate_postprocessor", :group => :all do |app|
        app.assets.register_postprocessor 'application/javascript', Ngannotate::Processor
      end
    end
  end
end
