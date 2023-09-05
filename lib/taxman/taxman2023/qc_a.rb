# frozen_string_literal: true

module Taxman2023
  # Income tax for the year
  class QcA < Factor
    def self.params
      %i[qc_y p qc_l]
    end
    attr_reader(*params)

    def amount
      evaluate "max(((qc_y / p) + qc_l), 0)"
    end
  end
end
