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

      def register(ident, assets_path:)
        define_class_context = ->(binding) do
          @@assets_path = assets_path
          def assets_path
            Pathname.new(@@assets_path)
          end
        end

        theme_name  = Rpictogrify::Inflector.camelize(ident.to_s)
        theme_class = "Rpictogrify::Themes::#{theme_name}"
        if Object.const_defined?(theme_class)
          Object.const_get(theme_class).class_eval(&define_class_context)
        else
          Rpictogrify::Themes.const_set(theme_name, Class.new(Rpictogrify::Themes::Base, &define_class_context))
        end
      end
    end
  end
end