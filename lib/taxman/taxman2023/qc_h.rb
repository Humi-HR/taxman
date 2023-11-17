# frozen_string_literal: true

module Taxman2023
  # Deduction for employment income
  class QcH < Factor
    EMPLOYMENT_INCOME_MAXIMUM_DEDUCTION = 1_315 * 100

    def self.params
      %i[qc_d p]
    end
    attr_reader(*params)

    def amount
      [(0.06 * qc_d), (EMPLOYMENT_INCOME_MAXIMUM_DEDUCTION / p)].min
    end
  end
end
