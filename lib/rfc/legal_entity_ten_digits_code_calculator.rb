# frozen_string_literal: true

require "i18n"

module Rfc
  class LegalEntityTenDigitsCodeCalculator
    DISCARDABLE_TERMS = DiscardableTerms::LegalEntity::ALL

    def initialize(legal_name:, day:, month:, year:)
      @legal_name = legal_name
      @day = day
      @month = month
      @year = year
    end

    def calculate
      name_code + birthday_code
    end

    private

    def name_code
      normalized_name = normalize(@legal_name)
      all_words = normalized_name.split(/\s+/).reject(&:empty?)
      significant_words = all_words.reject { |word| DISCARDABLE_TERMS.include?(word) }

      words_to_use = significant_words.empty? ? all_words : significant_words

      case words_to_use.length
      when 0
        raise ArgumentError, "Legal name is blank or invalid"
      when 1
        words_to_use[0][0..2]
      when 2
        "#{words_to_use[0][0]}#{words_to_use[1][0..1]}"
      else
        "#{words_to_use[0][0]}#{words_to_use[1][0]}#{words_to_use[2][0]}"
      end
    end

    def birthday_code
      "#{last_two_digits_of(@year)}#{formatted_in_two_digits(@month)}#{formatted_in_two_digits(@day)}"
    end

    def normalize(legal_name)
      return legal_name if legal_name.nil? || legal_name.empty?

      normalized = I18n.transliterate(legal_name).upcase
      normalized.gsub(/[^A-Z0-9\s]/, " ")
    end

    def formatted_in_two_digits(number)
      format("%02d", number)
    end

    def last_two_digits_of(number)
      formatted_in_two_digits(number % 100)
    end
  end
end
