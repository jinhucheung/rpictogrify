require 'forwardable'
require 'singleton'
require 'json'

module Rpictogrify
  module Themes
    class Base
      include Singleton
      extend SingleForwardable

      attr_reader :mapping, :resource, :ident
      def_delegators :instance, :mapping, :resource, :ident,
                                :shapes, :colors, :width, :height

      def initialize
        @ident    = get_ident
        @mapping  = parse_mapping
        @resource = parse_resource
      end

      def width
        view_box[2]
      end

      def height
        view_box[3]
      end

      def shapes
        mapping['shapes']
      end

      def colors
        mapping['colors']
      end

      private

      def get_ident
        Rpictogrify::Inflector.underscore(self.class.name).split('/').last
      end

      def parse_mapping
        JSON.parse File.read(Rpictogrify.themes_assets_path.join(ident, 'mapping.json'))
      end

      def parse_resource
        File.read(Rpictogrify.themes_assets_path.join(ident, 'resource.svg'))
      end

      def view_box
        @view_box ||= mapping['viewBox'].split(' ')
      end
    end
  end
end