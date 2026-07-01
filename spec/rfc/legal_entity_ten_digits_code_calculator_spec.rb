# frozen_string_literal: true

RSpec.describe Rfc::LegalEntityTenDigitsCodeCalculator do
  describe "#calculate" do
    it "returns the ten-digit code for a legal entity" do
      calculator = described_class.new(
        legal_name: "Mu Networks S.A.P.I. de C.V.",
        day: 10,
        month: 7,
        year: 2014
      )

      expect(calculator.calculate).to eq("MNP140710")
    end

    it "uses the first three significant words when the name has more than two" do
      calculator = described_class.new(
        legal_name: "Acme Global Services S.A. de C.V.",
        day: 1,
        month: 1,
        year: 2000
      )

      expect(calculator.calculate).to eq("AGS000101")
    end

    it "raises when the legal name is blank" do
      calculator = described_class.new(
        legal_name: "",
        day: 1,
        month: 1,
        year: 2000
      )

      expect { calculator.calculate }.to raise_error(ArgumentError, "Legal name is blank or invalid")
    end
  end
end
