# frozen_string_literal: true

require 'forwardable'
require 'singleton'
require 'json'

module Rpictogrify
  module Themes
    class Base
      include Singleton
      extend SingleForwardable

      attr_reader :mapping, :resource, :ident, :assets_path
      def_delegators :instance, :mapping, :resource, :ident, :assets_path,
                                :width, :height, :shapes, :colors, :symbol

      def initialize
        @ident = get_ident
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

      def symbol(id)
        resource.at_xpath("//*[@id='#{id}']")
      end

      def assets_path
        Rpictogrify.themes_assets_path.join(ident)
      end

      def mapping
        @mapping ||= JSON.parse(File.read(assets_path.join('mapping.json')))
      end

      def resource
        @resource ||= Nokogiri.XML(File.read(assets_path.join('resource.svg')))
      end

      private

      def get_ident
        Rpictogrify::Inflector.underscore(self.class.name).split('/').last
      end

      def view_box
        @view_box ||= mapping['viewBox'].split(' ')
      end
    end
  end
end