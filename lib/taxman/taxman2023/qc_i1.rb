# frozen_string_literal: true

module Taxman2023
  # This calculates the total annual taxable income from the income for the period for quebec
  class QcI1 < Factor
    def self.params
      %i[qc_g1 qc_f1 qc_h1 qc_csa1 qc_pr qc_g f qc_h2 qc_csa qc_j qc_j1]
    end
    attr_reader(*params)

    # rubocop:disable Metrics/AbcSize
    def amount
      [(qc_g1 - qc_f1 - qc_h1 - qc_csa1) + (qc_pr * (qc_g - f - qc_h2 - qc_csa)) - qc_j - qc_j1, 0].max
    end
    # rubocop:enable Metrics/AbcSize
  end
end
