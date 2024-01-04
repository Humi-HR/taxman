# frozen_string_literal: true

module Taxman2024
  # Deduction of additional employee QPP contributions for the pay period
  class QcCs < Factor
    def self.params
      %i[qc_c qc_c2]
    end
    attr_reader(*params)

    def amount
      (qc_c * (0.01 / Taxman2024::Qpp::RATE)) + qc_c2
    end
  end
end
