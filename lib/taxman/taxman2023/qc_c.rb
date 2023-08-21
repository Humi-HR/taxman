# frozen_string_literal: true

module Taxman2023
  # Calculates the QPP contribution for the period
  class QcC
    attr_reader :qc_a5, :qc_s3, :p, :qc_r

    def initialize(qc_a5:, qc_s3:, p:, qc_r:)
      @p = p.to_d
      @qc_a5 = qc_a5.to_d
      @qc_s3 = qc_s3.to_d
      @qc_r = qc_r.to_d
    end

    def self.params
      %i[qc_a5 qc_s3 p qc_r]
    end

    def amount
      [qpp_max, qpp_calculated].min.floor
    end

    # Calculates the maximum contributions to QPP for a year including any CPP
    # paid. Should the CPP paid (R) be 0, the factor will zero out.
    def qpp_max
      [Qpp::MAX - ((qc_r * (Qpp::RATE / Cpp::RATE)) + qc_a5), 0].max
    end

    # Calculates the QPP for an employee including CPP contributions.
    def qpp_calculated
      [Qpp::RATE * (qc_s3 - (Qpp::BASIC_EXEMPTION / p)), 0].max
    end
  end
end
