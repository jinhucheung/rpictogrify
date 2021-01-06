require 'rpictogrify/theme'

module Rpictogrify
  class Generator
    attr_reader :text, :theme

    def initialize(text, theme: nil)
      @text = text
      @theme = theme || Rpictorgrify.config.theme
    end

    def process; end
  end
end