# frozen_string_literal: true

require 'dentaku'

module Taxman2023
  # Income tax for the year
  class QcY < Factor
    RATES_AND_CONSTANTS = {
      49_275_00 => [0.14, 0],
      98_540_00 => [0.19, 2_463_00],
      119_910_00 => [0.24, 7_390_00],
      BigDecimal("Infinity") => [0.2575, 9_489_00]
    }.to_h { |k, v| [k.to_d, v.map(&:to_d)] }.freeze

    def self.params
      %i[qc_i qc_k1 qc_e p qc_q qc_q1]
    end
    attr_reader(*params)

    def amount
      evaluate "max((qc_t * qc_i) - qc_k - qc_k1 - (0.14 * qc_e) - (0.15 * p * qc_q) - (0.15 * p * qc_q1), 0)"
    end

    def evaluate(expression)
      Dentaku::Calculator.new.evaluate! expression, **context
    end

    def qc_t
      RATES_AND_CONSTANTS[bracket][0]
    end

    def qc_k
      RATES_AND_CONSTANTS[bracket][1]
    end

    def context
      instance_variables.inject({}) do |hash, attribute|
        hash[attribute.to_s[1..].to_sym] = instance_variable_get(attribute)
        hash
      end.merge(qc_t: qc_t, qc_k: qc_k)
    end

    private

    def bracket
      @bracket ||= RATES_AND_CONSTANTS.keys.sort.find { |bracket| qc_i <= bracket }
    end
  end
end
