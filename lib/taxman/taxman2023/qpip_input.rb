# frozen_string_literal: true

module Taxman2023
  # This input collects the factors specific to qpip calculation
  class QpipInput
    def initialize(parental_insurable_income_this_period:,
                   ytd_contributions:)
      @qc_s4 = parental_insurable_income_this_period
      @qc_a6 = ytd_contributions
    end

    def translate
      {
        qc_s4: (@qc_s4 * 100).to_d,
        qc_a6: (@qc_a6 * 100).to_d
      }
    end
  end
end
