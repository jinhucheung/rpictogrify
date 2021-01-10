# frozen_string_literal: true

require 'nokogiri'

require 'pathname'
require 'base64'

require 'rpictogrify/configuration'
require 'rpictogrify/generator'
require 'rpictogrify/inflector'

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
      @themes_assets_path ||= assets_path.join('themes')
    end
  end
end