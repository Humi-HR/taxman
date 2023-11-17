# frozen_string_literal: true

module Taxman2024
  # Deduction of additional employee QPP contributions on gratuities,
  # retroactive pay or similar lump-sum payments during the pay period
  class QcCsb < Factor
    def self.params
      %i[qc_cs qc_s3 qc_b2]
    end
    attr_reader(*params)

    def amount
      return 0 if qc_s3.zero? # avoid NaN

      qc_cs * (qc_b2 / qc_s3)
    end
  end
end
