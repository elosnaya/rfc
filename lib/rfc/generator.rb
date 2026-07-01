# frozen_string_literal: true

require "date"

module Rfc
  class Generator
    class InvalidDateError < Error; end

    def initialize(
      natural_ten_digits_calculator: NaturalTenDigitsCodeCalculator,
      legal_entity_ten_digits_calculator: LegalEntityTenDigitsCodeCalculator,
      homoclave_calculator: HomoclaveCalculator,
      verification_digit_calculator: VerificationDigitCalculator
    )
      @natural_ten_digits_calculator = natural_ten_digits_calculator
      @legal_entity_ten_digits_calculator = legal_entity_ten_digits_calculator
      @homoclave_calculator = homoclave_calculator
      @verification_digit_calculator = verification_digit_calculator
    end

    def for_natural_person(
      name:,
      first_last_name:,
      second_last_name:,
      day: nil,
      month: nil,
      year: nil,
      date_of_birth: nil
    )
      normalized_day, normalized_month, normalized_year = normalize_date(day, month, year, date_of_birth)

      ten_digits_code = @natural_ten_digits_calculator.new(
        name: name,
        first_last_name: first_last_name,
        second_last_name: second_last_name,
        day: normalized_day,
        month: normalized_month,
        year: normalized_year
      ).calculate

      homoclave = @homoclave_calculator.new(
        name: name,
        first_last_name: first_last_name,
        second_last_name: second_last_name
      ).calculate

      build_rfc(ten_digits_code, homoclave)
    rescue ArgumentError => e
      raise InvalidDateError, "Invalid date parameters: #{e.message}"
    end

    def for_legal_entity(
      legal_name:,
      day: nil,
      month: nil,
      year: nil,
      constitution_date: nil
    )
      normalized_day, normalized_month, normalized_year = normalize_date(day, month, year, constitution_date)

      ten_digits_code = @legal_entity_ten_digits_calculator.new(
        legal_name: legal_name,
        day: normalized_day,
        month: normalized_month,
        year: normalized_year
      ).calculate

      homoclave = @homoclave_calculator.new(legal_name: legal_name).calculate

      build_rfc(ten_digits_code, homoclave)
    rescue ArgumentError => e
      raise InvalidDateError, "Invalid date parameters: #{e.message}"
    end

    private

    def build_rfc(ten_digits_code, homoclave)
      rfc12_digits = "#{ten_digits_code.gsub("-", "")}#{homoclave}"
      verification_digit = @verification_digit_calculator.new(rfc12_digits).calculate

      "#{ten_digits_code}#{homoclave}#{verification_digit}"
    end

    def normalize_date(day, month, year, date_string)
      if !day.nil? && !month.nil? && !year.nil?
        [day, month, year]
      elsif present?(date_string)
        parse_date_string(date_string)
      else
        raise InvalidDateError, "Date information missing"
      end
    end

    def parse_date_string(date_string)
      parsed_date = try_parse_date(date_string)
      raise InvalidDateError, "Invalid date format: #{date_string}" unless parsed_date

      [parsed_date.day, parsed_date.month, parsed_date.year]
    end

    def try_parse_date(date_string)
      return nil unless present?(date_string)

      Date.strptime(date_string, "%d/%m/%Y")
    rescue ArgumentError
      begin
        Date.parse(date_string.to_s)
      rescue ArgumentError
        nil
      end
    end

    def present?(value)
      !value.nil? && !value.to_s.strip.empty?
    end
  end
end
