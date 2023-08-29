# frozen_string_literal: true

module Taxman2023
  # Deductions shown on line 19 of form TP-1015.3-V
  class QcJ < Factor
    def self.params
      %i[p qc_j3 qc_pr]
    end
    attr_reader *params

    def amount
      return qc_j3 if p == qc_pr # first pay period in year

      (p * qc_j3) / qc_pr
    end
  end
end
