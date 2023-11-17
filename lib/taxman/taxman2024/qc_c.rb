# frozen_string_literal: true

module Taxman2024
  # Calculates the QPP contribution for the period
  class QcC < Factor
    def self.params
      %i[qc_a5 qc_s3 p qc_r]
    end
    attr_reader(*params)

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
