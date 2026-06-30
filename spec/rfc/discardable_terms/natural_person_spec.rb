# frozen_string_literal: true

RSpec.describe Rfc::DiscardableTerms::NaturalPerson do
  describe "ALL" do
    it "includes articles, company abbreviations, and discardable terms" do
      expect(described_class::ALL).to include("DE", "SA", "MC")
    end

    it "is frozen" do
      expect(described_class::ALL).to be_frozen
    end
  end

  describe "FORBIDDEN_WORDS" do
    it "includes SAT forbidden word codes" do
      expect(described_class::FORBIDDEN_WORDS).to include("BUEI", "CACA", "PUTO")
    end

    it "is frozen" do
      expect(described_class::FORBIDDEN_WORDS).to be_frozen
    end
  end
end
