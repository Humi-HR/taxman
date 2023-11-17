# frozen_string_literal: true

module Taxman2023
  # Deduction of additional employee QPP contributions for the pay period
  class QcCs < Factor
    def self.params
      %i[qc_c]
    end
    attr_reader(*params)

    def amount
      qc_c * (0.01 / Taxman2023::Qpp::RATE)
    end
  end
end
