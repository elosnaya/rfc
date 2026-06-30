# frozen_string_literal: true

module Rfc
  class NaturalTenDigitsCodeCalculator
    VOWEL_PATTERN = /[AEIOU]+/
    DISCARDABLE_TERMS = DiscardableTerms::NaturalPerson::ALL
    FORBIDDEN_WORDS = DiscardableTerms::NaturalPerson::FORBIDDEN_WORDS

    def initialize(name:, first_last_name:, second_last_name:, day:, month:, year:)
      @name = name
      @first_last_name = first_last_name
      @second_last_name = second_last_name
      @day = day
      @month = month
      @year = year
    end

    def calculate
      obfuscate_forbidden_words(name_code) + birthday_code
    end

    private

    def obfuscate_forbidden_words(name_code)
      FORBIDDEN_WORDS.each do |forbidden|
        return "#{name_code[0..2]}X" if forbidden == name_code
      end
      name_code
    end

    def name_code
      return first_last_name_empty_form if first_last_name_empty?
      return second_last_name_empty_form if second_last_name_empty?
      return first_last_name_too_short_form if first_last_name_is_too_short?

      normal_form
    end

    def second_last_name_empty_form
      first_two_letters_of(@first_last_name) + first_two_letters_of(filter_name(@name))
    end

    def birthday_code
      "#{@year.to_s[-2, 2]}#{format('%02d', @month)}#{format('%02d', @day)}"
    end

    def second_last_name_empty?
      normalized = normalize(@second_last_name)
      normalized.nil? || normalized.empty?
    end

    def first_last_name_empty_form
      first_two_letters_of(@second_last_name) + first_two_letters_of(filter_name(@name))
    end

    def first_last_name_empty?
      normalized = normalize(@first_last_name)
      normalized.nil? || normalized.empty?
    end

    def first_last_name_too_short_form
      first_letter_of(@first_last_name) +
        first_letter_of(@second_last_name) +
        first_two_letters_of(filter_name(@name))
    end

    def first_two_letters_of(word)
      normalized_word = normalize(word)
      normalized_word[0..1]
    end

    def first_last_name_is_too_short?
      normalize(@first_last_name).length <= 2
    end

    def normal_form
      first_letter_of(@first_last_name) +
        first_vowel_excluding_first_character_of(@first_last_name) +
        first_letter_of(@second_last_name) +
        first_letter_of(filter_name(@name))
    end

    def filter_name(name)
      normalize(name).strip.sub(/^(MA|MA\.|MARIA|JOSE)\s+/, "")
    end

    def first_letter_of(word)
      normalized_word = normalize(word)
      normalized_word[0]
    end

    def normalize(word)
      return word if word.nil? || word.empty?

      normalized_word = I18n.transliterate(word).upcase
      remove_discardable_terms(normalized_word, DISCARDABLE_TERMS)
    end

    def remove_discardable_terms(word, discardable_terms)
      new_word = word.dup
      discardable_terms.each do |term|
        new_word.gsub!("#{term} ", "")
      end
      new_word
    end

    def first_vowel_excluding_first_character_of(word)
      normalized_word = normalize(word)[1..]
      match = VOWEL_PATTERN.match(normalized_word)
      raise ArgumentError, "Word doesn't contain a vowel: #{normalized_word}" if match.nil?

      match.to_s[0]
    end
  end
end
