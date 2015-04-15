require 'execjs'
require_relative 'processor_common'

module Ngannotate
  class Processor
    include ProcessorCommon

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def call(input)
      process_data(input)
    end
  end
end
