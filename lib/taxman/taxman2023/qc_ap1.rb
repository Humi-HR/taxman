# frozen_string_literal: true

module Taxman2023
  # Calculates the CPP contribution for the period
  class QcAp1
    attr_reader :qc_a7, :qc_s4

    def initialize(qc_a7:, qc_s4:)
      @qc_a7 = qc_a7.to_d
      @qc_s4 = qc_s4.to_d
    end

    def self.params
      %i[qc_a7 qc_s4]
    end

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
