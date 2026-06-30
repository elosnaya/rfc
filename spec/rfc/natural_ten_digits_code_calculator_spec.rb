# frozen_string_literal: true

RSpec.describe Rfc::NaturalTenDigitsCodeCalculator do
  describe "#calculate" do
    it "returns the ten-digit code for a natural person" do
      calculator = described_class.new(
        name: "Luis Alberto",
        first_last_name: "Osnaya",
        second_last_name: "Balderas",
        day: 21,
        month: 7,
        year: 1986
      )

      expect(calculator.calculate).to eq("OABL860721")
    end

    it "obfuscates forbidden name codes" do
      calculator = described_class.new(
        name: "Yolanda",
        first_last_name: "Burrero",
        second_last_name: "Estrada",
        day: 1,
        month: 1,
        year: 1990
      )

      expect(calculator.calculate).to eq("BUEX900101")
    end

    it "uses the given name after SAT discardable term normalization" do
      calculator = described_class.new(
        name: "Maria Fernanda",
        first_last_name: "Lopez",
        second_last_name: "Garcia",
        day: 15,
        month: 3,
        year: 1985
      )

      expect(calculator.calculate).to eq("LOGM850315")
    end

    it "handles an empty second last name" do
      calculator = described_class.new(
        name: "Juan",
        first_last_name: "Perez",
        second_last_name: "",
        day: 10,
        month: 5,
        year: 1992
      )

      expect(calculator.calculate).to eq("PEJU920510")
    end

    it "raises when the first last name has no vowel after the first character" do
      calculator = described_class.new(
        name: "Ana",
        first_last_name: "Xyz",
        second_last_name: "Lopez",
        day: 1,
        month: 1,
        year: 1990
      )

      expect { calculator.calculate }.to raise_error(ArgumentError, /doesn't contain a vowel/)
    end
  end
end
