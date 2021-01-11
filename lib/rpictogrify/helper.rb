# frozen_string_literal: true

module Rpictogrify
  module Helper
    def rpictogrify_for(text, options = {})
      Rpictogrify.generate(text, options)
    end

    def rpictogrify_url(text, options = {})
      Rpictogrify.path_to_url(rpictogrify_for(text, options))
    end

    def rpictogrify_tag(text, options = {})
      html_opts = {alt: text}.merge(options.delete(:html) || {})
      if defined?(ActionView::Helpers::AssetTagHelper)
        extend ActionView::Helpers::AssetTagHelper
        image_tag(rpictogrify_url(text, options), html_opts)
      else
        tag = "<img class='#{html_opts[:class]}' src='#{rpictogrify_url(text, options)}' alt='#{html_opts[:alt]}' width='#{html_opts[:width]}' height='#{html_opts[:height]}' />"
        tag.respond_to?(:html_safe) ? tag.html_safe : tag
      end
    end
  end
end