# frozen_string_literal: true

module Rpictogrify
  class Configuration
    # default theme, one of these themes: avataars_female, avataars_male, male_flat, monsters. default is monsters
    attr_accessor :theme

    # the size of pictogram. default is 300
    attr_accessor :weight

    # pictogram directory. default is public/system
    attr_accessor :base_path

    def initialize
      @theme = :monsters

      @weight = 300

      @base_path = 'public/system'
    end
  end
end