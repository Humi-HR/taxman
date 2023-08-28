# frozen_string_literal: true

module Taxman2023
  # This calculates the total annual taxable income from the income for the period for quebec
  class QcI < Factor
    def self.params
      %i[p qc_g f qc_h qc_csa qc_j qc_j1]
    end
    attr_reader *params

    def amount
      i = p * (qc_g - f - qc_h - qc_csa) - qc_j - qc_j1
      (i < 0) ? 0 : i
    end
  end
end
