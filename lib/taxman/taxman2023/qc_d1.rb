# frozen_string_literal: true

module Taxman2023
  # Undescribed factor as part of QC bonus tax calculation
  class QcD1 < Factor
    def self.params
      %i[qc_b1 qc_b2 qc_g1 qc_d]
    end
    attr_reader(*params)

    def amount
      qc_b1 + qc_b2 + qc_g1 + qc_d
    end
  end
end
