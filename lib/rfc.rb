# frozen_string_literal: true

require_relative "rfc/version"
require_relative "rfc/discardable_terms/natural_person"
require_relative "rfc/verification_digit_calculator"

module Rfc
  class Error < StandardError; end
end
