# frozen_string_literal: true

require 'nokogiri'
require 'xxhash'

require 'pathname'
require 'base64'

require 'rpictogrify/configuration'
require 'rpictogrify/generator'
require 'rpictogrify/inflector'
require 'rpictogrify/helper'
require 'rpictogrify/extension'

module Rpictogrify
  class << self
    # example
    #   Rpictogrify.generate 'jim', theme: :avataars_male
    def generate(text, options = {})
      Generator.call(text, options)
    end

    def config
      @config ||= Configuration.new
    end

    def configure(&block)
      config.instance_exec(&block)
    end

    def root
      @root ||= Pathname.new(File.expand_path('../..', __FILE__))
    end

    def assets_path
      @assets_path ||= root.join('assets')
    end

    def themes_assets_path
      @themes_assets_path ||= config.themes_assets_path || assets_path.join('themes')
    end

    def path_to_url(path)
      path.to_s.sub('public/', '/')
    end
  end
end
