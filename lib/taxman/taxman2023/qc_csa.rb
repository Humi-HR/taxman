# frozen_string_literal: true

module Taxman2023
  # Deduction of additional employee QPP contributions on the employee’s gross pensionable
  # earnings for the pay period, excluding gratuities, retroactive pay or similar lump-sum payments
  class QcCsa < Factor
    def self.params
      %i[qc_cs qc_s3 qc_b2]
    end
    attr_reader(*params)

    def amount
      evaluate "if(qc_s3 = 0, 0, qc_cs * ((qc_s3 - qc_b2) / qc_s3))"
    end
  end
end
