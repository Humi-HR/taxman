# frozen_string_literal: true

module Taxman2024
  # This calculates J1 value for deductions
  class QcJ1 < QcJ
    def self.params
      %i[p qc_pr qc_j1_raw qc_j1_calc]
    end

    def initialize(p:, qc_pr:, qc_j1_raw:, qc_j1_calc:)
      super(p: p, qc_pr: qc_pr, qc_j_raw: qc_j1_raw, qc_j_calc: qc_j1_calc)
    end
  end
end
