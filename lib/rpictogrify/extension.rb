module Rpictogrify
  module Extension
    def self.included(base)
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end

    module ClassMethods
      def rpictogrify_on(textable, options = {})
        rpictogrify_settings[:textable] = textable
        rpictogrify_settings[:options]  = options
      end

      def rpictogrify_settings
        @rpictogrify_settings ||= {}
      end
    end

    module InstanceMethods
      def rpictogrify_path(text = nil, options = {})
        Rpictogrify.generate(text || rpictogrify_text, rpictogrify_options.merge(options || {}))
      end

      def rpictogrify_url(text = nil, options = {})
        Rpictogrify.path_to_url(rpictogrify_path(text, options))
      end

      private

      def rpictogrify_text
        textable = self.class.rpictogrify_settings[:textable]
        return unless textable && respond_to?(textable)
        self.send(textable)
      end

      def rpictogrify_options
        options = self.class.rpictogrify_settings[:options] || {}
        if options[:theme]
          if options[:theme].respond_to?(:call)
            options[:theme] = self.instance_exec(&options[:theme])
          elsif respond_to?(options[:theme])
            options[:theme] = self.send(options[:theme])
          end
        end
        options
      end
    end
  end
end