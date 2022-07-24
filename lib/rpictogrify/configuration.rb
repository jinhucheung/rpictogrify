# frozen_string_literal: true

require 'rpictogrify/theme'

module Rpictogrify
  class Configuration
    # default theme, one of these themes: avataars_female, avataars_male, male_flat, monsters. default is :monsters
    attr_accessor :theme

    # pictogram directory. default is 'public/system'
    attr_accessor :base_path

    def initialize
      @theme = :monsters

      @base_path = 'public/system'
    end

    # register a custome theme with assets. assets see assets/themes.
    def register_theme(ident, assets_path:)
      Rpictogrify::Theme.register(ident, assets_path: assets_path)
    end
  end
end
