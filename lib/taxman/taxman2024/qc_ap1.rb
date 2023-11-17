# frozen_string_literal: true

module Taxman2024
  # Calculates the CPP contribution for the period
  class QcAp1 < Factor
    def self.params
      %i[qc_a7 qc_s4]
    end
    attr_reader(*params)

    def amount
      [qpip_max, qpip_calculated].min.ceil
    end

    def qpip_max
      [Qpip::EMPLOYER_MAX - qc_a7, 0].max
    end

    def qpip_calculated
      [Qpip::EMPLOYER_RATE * qc_s4, 0].max
    end
  end
end
