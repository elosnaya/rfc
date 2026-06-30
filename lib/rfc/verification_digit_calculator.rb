# frozen_string_literal: true

module Rfc
  class VerificationDigitCalculator
    MAPPING = {
      "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6,
      "7" => 7, "8" => 8, "9" => 9, "A" => 10, "B" => 11, "C" => 12, "D" => 13,
      "E" => 14, "F" => 15, "G" => 16, "H" => 17, "I" => 18, "J" => 19, "K" => 20,
      "L" => 21, "M" => 22, "N" => 23, "&" => 24, "O" => 25, "P" => 26, "Q" => 27,
      "R" => 28, "S" => 29, "T" => 30, "U" => 31, "V" => 32, "W" => 33, "X" => 34,
      "Y" => 35, "Z" => 36, " " => 37, "Ñ" => 38
    }.freeze

    def initialize(rfc12_digits)
      @rfc12_digits = rfc12_digits
    end

    def calculate
      rfc12_padded = @rfc12_digits.ljust(12, " ")
      sum = 0
      (0..11).each do |i|
        sum += map_digit(rfc12_padded[i]) * (13 - i)
      end
      reminder = sum % 11

      return "0" if reminder.zero?

      (11 - reminder).to_s(16).upcase
    end

    private

    def map_digit(character)
      return MAPPING[character] if MAPPING.key?(character)

      0
    end
  end
end
