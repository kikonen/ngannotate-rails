require 'ngannotate/processor'

module Ngannotate
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "ngannotate-rails.add_ngannotate_postprocessor", :group => :all do |app|
        app.assets.register_postprocessor 'application/javascript', Ngannotate::Processor
      end
    end
  end
end
