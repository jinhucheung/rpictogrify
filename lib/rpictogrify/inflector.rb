# frozen_string_literal: true

module Rpictogrify
  module Inflector
    extend self

    def underscore(camel_cased_word)
      return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
      word = camel_cased_word.to_s.gsub("::", "/")
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
      word.tr!('-', '_')
      word.downcase!
      word
    end

    def camelize(term, uppercase_first_letter = true)
      if uppercase_first_letter
        term = term.sub(/^[a-z\d]*/) { |match| match.capitalize }
      else
        term = term.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |match| match.downcase }
      end
      term.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
    end
  end
end