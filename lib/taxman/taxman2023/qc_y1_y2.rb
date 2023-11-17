# frozen_string_literal: true

module Taxman2023
  # Income tax for the year taking into account variables B1 and B2
  class QcY1Y2 < Factor
    def self.params
      %i[qc_i1 qc_b1 qc_b2 qc_csb1 qc_csb qc_k1 qc_e p qc_q qc_q1]
    end
    attr_reader(*params)

    def amount
      [(qc_t * income_amounts) - qc_k - qc_k1 - (0.14 * qc_e) - (0.15 * p * qc_q) - (0.15 * p * qc_q1), 0].max
    end

    def income_amounts
      qc_i1 + qc_b1 + qc_b2 - qc_csb1 - qc_csb
    end

    def qc_t
      Taxman2023::QcY::RATES_AND_CONSTANTS[bracket][0]
    end

    def qc_k
      Taxman2023::QcY::RATES_AND_CONSTANTS[bracket][1]
    end

    private

    def bracket
      @bracket ||= Taxman2023::QcY::RATES_AND_CONSTANTS.keys.sort.find do |bracket|
        qc_i1 + qc_b1 + qc_b2 <= bracket
      end
    end
  end
end
