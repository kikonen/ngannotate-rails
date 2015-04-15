require 'execjs'
require 'sprockets/processor'
require_relative 'processor_common'

module Ngannotate
  class Processor < Sprockets::Processor
    include ProcessorCommon

    def evaluate(context, locals)
      input = {
        filename: @file,
        data: data,
      }
      process_data(input)
    end
  end
end
