# frozen_string_literal: true

module Taxman2024
  # Calculates the CPP contribution for the period
  class QcAp < Factor
    def self.params
      %i[qc_a6 qc_s4]
    end
    attr_reader(*params)

    def amount
      [qpip_max, qpip_calculated].min.ceil
    end

    def qpip_max
      [Qpip::EMPLOYEE_MAX - qc_a6, 0].max
    end

    def qpip_calculated
      [Qpip::EMPLOYEE_RATE * qc_s4, 0].max
    end
  end
end
