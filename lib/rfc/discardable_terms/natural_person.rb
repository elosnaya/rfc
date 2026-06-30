# frozen_string_literal: true

module Rfc
  module DiscardableTerms
    # Dictionary of discardable terms and forbidden words for natural persons (personas físicas).
    # Based on SAT specification.
    module NaturalPerson
      ARTICLES_AND_PREPOSITIONS = %w[
        DE LA LAS DEL LOS Y
        EN CON SUS PARA POR AL E
        OF THE AND
      ].freeze

      COMPANY_TYPE_ABBREVIATIONS = %w[
        SA SC SRL SCS CIA COOP SOC CO COMPANY
        CV RL S A C V
        COMPAÑIA
      ].freeze

      DISCARDABLE_TERMS = %w[MC VON MAC VAN MI].freeze

      ALL = (
        ARTICLES_AND_PREPOSITIONS +
        COMPANY_TYPE_ABBREVIATIONS +
        DISCARDABLE_TERMS
      ).freeze

      FORBIDDEN_WORDS = %w[
        BUEI BUEY CACA CACO CAGA KOGE KAKA MAME KOJO KULO
        CAGO COGE COJE COJO FETO JOTO KACO KAGO MAMO MEAR MEON
        MION MOCO MULA PEDA PEDO PENE PUTA PUTO QULO RATA RUIN
      ].freeze
    end
  end
end
