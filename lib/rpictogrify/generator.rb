# frozen_string_literal: true

require 'rpictogrify/pictogram'

module Rpictogrify
  module Generator
    extend self

    # example
    #   Rpictogrify::Generator.call 'jim', theme: :avataars_male
    def call(text, options = {})
      pictogram = Rpictogrify::Pictogram.new(text, options)
      pictogram.generate
    end
  end
end