# frozen_string_literal: true

module Taxman2024
  # Income tax for the year
  class QcA < Factor
    def self.params
      %i[qc_y p qc_l]
    end
    attr_reader(*params)

    def amount
      [((qc_y / p) + qc_l), 0].max
    end
  end
end
