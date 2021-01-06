require 'forwardable'
require 'singleton'
require 'json'

module Rpictogrify
  module Themes
    class Base
      include Singleton
      extend SingleForwardable

      attr_reader :mapping, :resource, :ident
      def_delegators :instance, :mapping, :resource, :ident

      def initialize
        @ident    = get_ident
        @mapping  = parse_mapping
        @resource = parse_resource
      end

      private

      def get_ident
        ident = self.class.name.split('::').last
        ident.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        ident.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
        ident.tr!('-', '_')
        ident.downcase!
        ident
      end

      def parse_mapping
        JSON.parse File.read(Rpictogrify.themes_assets_path.join(ident, 'mapping.json')) rescue {}
      end

      def parse_resource
        File.read(Rpictogrify.themes_assets_path.join(ident, 'resource.svg'))
      end
    end
  end
end