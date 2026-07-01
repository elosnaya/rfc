# frozen_string_literal: true

RSpec.describe Rfc::DiscardableTerms::LegalEntity do
  describe "ALL" do
    it "includes articles, company abbreviations, and discardable terms" do
      expect(described_class::ALL).to include("DE", "SA", "S", "A", "C", "V", "COMPAÑIA", "MC")
    end

    it "is frozen" do
      expect(described_class::ALL).to be_frozen
    end
  end
end
