# frozen_string_literal: true

module Taxman2023
  # This input collects the factors specific to cpp and qpp calculation
  class PensionInput
    def initialize(pensionable_income_this_period:,
                   ytd_cpp_contributions:,
                   ytd_qpp_contributions:,
                   contribution_months_this_year:,
                   pensionable_non_periodic_income_this_period: 0)
      @pensionable_income_this_period = pensionable_income_this_period
      @pensionable_non_periodic_income_this_period = pensionable_non_periodic_income_this_period
      @ytd_cpp_contributions = ytd_cpp_contributions
      @ytd_qpp_contributions = ytd_qpp_contributions
      @contribution_months_this_year = contribution_months_this_year
    end

    # rubocop:disable Metrics/MethodLength
    def translate
      pensionable_income_this_period = (@pensionable_income_this_period * 100).to_d
      pensionable_non_periodic_income_this_period = (@pensionable_non_periodic_income_this_period * 100).to_d
      pensionable_periodic_income_this_period =
        pensionable_income_this_period - pensionable_non_periodic_income_this_period
      cpp_ytd = (@ytd_cpp_contributions * 100).to_d
      qpp_ytd = (@ytd_qpp_contributions * 100).to_d

      {
        # T4127
        pi: pensionable_income_this_period,
        pi_periodic: pensionable_periodic_income_this_period,
        b_pensionable: pensionable_non_periodic_income_this_period,
        d: cpp_ytd,
        dq: qpp_ytd,

        # TP-1015.3
        qc_s3: pensionable_income_this_period,
        qc_s3_periodic: pensionable_periodic_income_this_period,
        qc_b2_pensionable: pensionable_non_periodic_income_this_period,
        qc_a5: qpp_ytd,
        qc_r: cpp_ytd,

        # Shared
        pm: @contribution_months_this_year
      }
    end
    # rubocop:enable Metrics/MethodLength
  end
end
