# frozen_string_literal: true

module Taxman2023
  # Deduction for employment income
  class QcH2 < Factor
    def self.params
      %i[qc_d1 qc_h1 qc_pr]
    end
    attr_reader(*params)

    def amount
      evaluate "min((0.06 * qc_d1), 131500 - qc_h1) / qc_pr"
    end
  end
end
