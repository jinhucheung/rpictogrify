# frozen_string_literal: true

module Rpictogrify
  class Configuration
    # default theme, one of these themes: avataars_female, avataars_male, male_flat, monsters. default is :monsters
    attr_accessor :theme

    # pictogram directory. default is 'public/system'
    attr_accessor :base_path

    # pictogram themes directory. default is located inside gem instalation folder at assets/themes
    attr_accessor :themes_assets_path

    def initialize
      @theme = :monsters

      @base_path = 'public/system'

      @themes_assets_path = nil
    end
  end
end
