# frozen_string_literal: true

module Taxman2023
  # This input collects the factors relevant to ei calculation
  class EiInput
    def initialize(insurable_income_this_period:,
                   employees_ytd_contributions:)
      @ie = insurable_income_this_period
      @d1 = employees_ytd_contributions
    end

    def translate
      {
        ie: (@ie * 100).to_d,
        d1: (@d1 * 100).to_d
      }
    end
  end
end
