# frozen_string_literal: true

module Taxman2024
  # Income tax for the year
  class QcY < Factor
    RATES_AND_CONSTANTS = {
      51_780_00 => [0.14, 0],
      103_545_00 => [0.19, 2_589_00],
      126_000_00 => [0.24, 7_766_00],
      BigDecimal("Infinity") => [0.2575, 9_971_00]
    }.to_h { |k, v| [k.to_d, v.map(&:to_d)] }.freeze

    def self.params
      %i[qc_i qc_k1 qc_e p qc_q qc_q1]
    end
    attr_reader(*params)

    def amount
      [(qc_t * qc_i) - qc_k - qc_k1 - (0.14 * qc_e) - (0.15 * p * qc_q) - (0.15 * p * qc_q1), 0].max
    end

    def qc_t
      RATES_AND_CONSTANTS[bracket][0]
    end

    def qc_k
      RATES_AND_CONSTANTS[bracket][1]
    end

    private

    def bracket
      @bracket ||= RATES_AND_CONSTANTS.keys.sort.find { |bracket| qc_i <= bracket }
    end
  end
end
