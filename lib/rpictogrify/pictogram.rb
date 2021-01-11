# frozen_string_literal: true

require 'rpictogrify/theme'

module Rpictogrify
  class Pictogram
    # BUMP UP if avatar algorithm changes
    VERSION = 1

    attr_reader :text, :options, :theme, :uid

    def initialize(text, options = {})
      @text    = text.to_s
      @options = options
      @theme   = Rpictogrify::Theme.find(options[:theme] || Rpictogrify.config.theme)
      @uid     = generate_uid
    end

    def generate
      File.write(path, svg) unless File.exist?(path)
      path
    end

    def svg
      includes = symbols.map do |shape, symbol|
        fillable = fill[shape] ? "fill='#{fill[shape]}'" : ''
        "<svg class='#{shape}' #{fillable} xmlns='http://www.w3.org/2000/svg'>#{symbol}</svg>"
      end

      <<-XML.strip
        <svg viewBox="0 0 #{size} #{size}" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
          <g>
            <rect fill="#{colors['background']}" x="0" y="0" width="#{size}" height="#{size}"></rect>
            #{includes.join("\n")}
          </g>
        </svg>
      XML
    end

    def base64
      "data:image/svg+xml;base64,#{Base64.encode64(svg)[0...-1]}"
    end

    def size
      @size ||= theme.width || 300
    end

    def path
      @path ||= begin
        dir = File.join(self.class.base_path, theme.ident)
        FileUtils.mkdir_p(dir)

        File.join(dir, "#{[text, uid].join('-')}.svg")
      end
    end

    class << self
      def base_path
        File.join (Rpictogrify.config.base_path || 'public/system'), 'rpictogrify', "#{VERSION}"
      end
    end

    private

    def generate_uid
      XXhash.xxh32(text.to_s).abs.to_s.gsub('0', '1')
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

    def symbols
      @symbols ||= shapes.inject({}) do |result, (shape, value)|
        symbol = theme.symbol("#{shape}-#{value}")
        result[shape] = symbol&.children.to_s.gsub('\n', '')
        result
      end
    end
  end
end