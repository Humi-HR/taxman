# frozen_string_literal: true

module Taxman2023
  # Deduction of additional employee QPP contributions for the pay period
  class QcCs < Factor
    def self.params
      %i[qc_c]
    end
    attr_reader(*params)

    def amount
      evaluate "qc_c * (0.01 / 0.0640)"
    end
  end
end
