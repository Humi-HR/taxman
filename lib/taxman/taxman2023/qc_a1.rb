# frozen_string_literal: true

module Taxman2023
  # Income withheld from bonuses
  class QcA1 < Factor
    def self.params
      %i[qc_y1 qc_y2]
    end
    attr_reader(*params)

    def amount
      [qc_y2 - qc_y1, 0].max
    end
  end
end
