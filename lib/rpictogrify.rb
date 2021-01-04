require 'pathname'
require 'logger'

require 'rpictorgrify/configuration'
require 'rpictorgrify/generator'

module Rpictorgrify
  class << self
    def generate(text, theme: nil)
      Generator.new(text, theme: theme || config.theme).process
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

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end