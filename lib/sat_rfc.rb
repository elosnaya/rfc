# frozen_string_literal: true

require "i18n"

I18n.available_locales = [:en]
I18n.default_locale = :en

require_relative "rfc/version"
require_relative "rfc/discardable_terms/natural_person"
require_relative "rfc/discardable_terms/legal_entity"
require_relative "rfc/verification_digit_calculator"
require_relative "rfc/homoclave_calculator"
require_relative "rfc/natural_ten_digits_code_calculator"

module Rfc
  class Error < StandardError; end
end

require_relative "rfc/generator"
