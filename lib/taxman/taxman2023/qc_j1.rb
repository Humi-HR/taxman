# frozen_string_literal: true

module Taxman2023
  # Annual deductions that we authorized after the individual completed form TP-1016-V
  class QcJ1 < Factor
    def self.params
      %i[p qc_j2 qc_pr]
    end
    attr_reader *params

    def amount
      return qc_j2 if p == qc_pr # first pay period in year

      (p * qc_j2) / qc_pr
    end
  end
end
