# frozen_string_literal: true

module Taxman2024
  # This calculates J value for deductions
  class QcJ < Factor
    def initialize(p:, qc_pr:, qc_j_raw:, qc_j_calc:)
      super
      if qc_j_raw.positive? && qc_j_calc.positive?
        @qc_j = qc_j_calc
      elsif qc_j_raw.zero?
        @qc_j = 0
      else
        @qc_j = (p * qc_j_raw) / qc_pr
        @calculated = @qc_j
      end
    end

    def self.params
      %i[p qc_pr qc_j_raw qc_j_calc]
    end
    attr_reader(*params)

    def amount
      @qc_j
    end

    def calc
      @calculated
    end
  end

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
