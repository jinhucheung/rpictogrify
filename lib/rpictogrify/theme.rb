# frozen_string_literal: true

require 'rpictogrify/themes/base'
require 'rpictogrify/themes/avataars_female'
require 'rpictogrify/themes/avataars_male'
require 'rpictogrify/themes/male_flat'
require 'rpictogrify/themes/monsters'

module Rpictogrify
  class Theme
    class << self
      def find(ident)
        theme_name = Rpictogrify::Inflector.camelize(ident.to_s)
        Object.const_get("Rpictogrify::Themes::#{theme_name}")
      rescue NameError
        raise ArgumentError.new('The ident argument must be one of themes: avataars_female, avataars_male, male_flat, monsters')
      end
    end
  end
end