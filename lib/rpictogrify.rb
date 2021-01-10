require 'pathname'
require 'logger'

require 'rpictogrify/configuration'
require 'rpictogrify/generator'
require 'rpictogrify/inflector'

module Rpictogrify
  class << self
    def generate(text, theme = nil)
      Generator.call(text, theme || config.theme)
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

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end