require 'rpictogrify/pictogram'

module Rpictogrify
  module Generator
    extend self

    def call(text, theme = nil)
      pictogram = Rpictogrify::Pictogram.new(text, theme)
      pictogram.generate
    end
  end
end