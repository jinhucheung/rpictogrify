require 'rpictogrify/theme'

module Rpictogrify
  class Pictogram
    attr_reader :text, :theme, :uid

    def initialize(text, theme = nil)
      @text  = text
      @theme = Rpictogrify::Theme.find(theme)
      @uid   = generate_uid
    end

    def generate; end

    def width
      theme.width
    end

    def height
      theme.height
    end

    def shapes
      @shapes ||= theme.shapes.each_with_index.inject({}) do |result, ((shape, value), index)|
        result[shape] = uid[index].nil? || uid[index].to_i > value['length'] ? '01' : uid[index].rjust(2, '0')
        result
      end
    end

    def colors
      @colors ||= theme.colors.each_with_index.inject({}) do |result, ((part, values), index)|
        result[part] = values[uid[index].to_i] || values.first
        result
      end
    end

    def fill
      @fill ||= theme.shapes.inject({}) do |result, (shape, value)|
        color = colors[value['fill']]
        result[shape] = color if color
        result
      end
    end

    private

    def generate_uid
      text.hash.abs.to_s.gsub('0', '1')
    end
  end
end