# frozen_string_literal: true

RSpec.describe Rfc::Generator do
  subject(:generator) { described_class.new }

  describe "#for_natural_person" do
    it "returns the full RFC for a natural person using date_of_birth" do
      rfc = generator.for_natural_person(
        name: "Juan Carlos",
        first_last_name: "Perez",
        second_last_name: "Garcia",
        date_of_birth: "15/03/1990"
      )

      expect(rfc).to eq("PEGJ900315PE9")
    end

    it "returns the full RFC when day, month, and year are provided" do
      rfc = generator.for_natural_person(
        name: "Juan Carlos",
        first_last_name: "Perez",
        second_last_name: "Garcia",
        day: 15,
        month: 3,
        year: 1990
      )

      expect(rfc).to eq("PEGJ900315PE9")
    end

    it "strips JOSE prefix from the given name" do
      rfc = generator.for_natural_person(
        name: "Jose Antonio",
        first_last_name: "Perez",
        second_last_name: "Luna",
        date_of_birth: "01/05/1988"
      )

      expect(rfc).to eq("PELA880501UC9")
    end

    it "raises InvalidDateError when date information is missing" do
      expect do
        generator.for_natural_person(
          name: "Juan Carlos",
          first_last_name: "Perez",
          second_last_name: "Garcia"
        )
      end.to raise_error(Rfc::Generator::InvalidDateError, "Date information missing")
    end

    it "raises InvalidDateError when date_of_birth has an invalid format" do
      expect do
        generator.for_natural_person(
          name: "Juan Carlos",
          first_last_name: "Perez",
          second_last_name: "Garcia",
          date_of_birth: "not-a-date"
        )
      end.to raise_error(Rfc::Generator::InvalidDateError, /Invalid date format/)
    end
  end
end
