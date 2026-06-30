# frozen_string_literal: true

RSpec.describe Rfc::VerificationDigitCalculator do
  describe "#calculate" do
    it "returns the verification digit for a natural person RFC prefix" do
      calculator = described_class.new("OABL8607213H")

      expect(calculator.calculate).to eq("6")
    end

    it "pads input shorter than 12 characters with spaces" do
      calculator = described_class.new("ABC")

      expect(calculator.calculate).to match(/\A[0-9A-F]\z/)
    end

    it "returns 0 when the weighted sum is divisible by 11" do
      calculator = described_class.new("RFC000000003")

      expect(calculator.calculate).to eq("0")
    end

    it "returns 0 for unmapped characters" do
      calculator = described_class.new("!!!!!!!!!!!!")

      expect(calculator.calculate).to eq("0")
    end
  end
end
