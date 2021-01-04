module Rpictogrify
  class Configuration
    # default theme: monsters
    attr_accessor :theme

    def initialize
      @theme = :monsters
    end
  end
end