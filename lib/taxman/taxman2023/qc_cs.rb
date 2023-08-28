# frozen_string_literal: true

module Taxman2023
  # Deduction of additional employee QPP contributions for the pay period
  class QcCS < Factor
    def self.params
      %i[qc_c]
    end
    attr_reader *params

    def amount
      qc_c * (0.01 / 0.0640)
    end
  end
end
