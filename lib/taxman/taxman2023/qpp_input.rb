# frozen_string_literal: true

module Taxman2023
  # This input collects the factors specific to qpp calculation
  class QppInput
    def initialize(pensionable_income_this_period:,
                   ytd_contributions:,
                   pensionable_non_periodic_income_this_period: 0)
      @qc_s3 = pensionable_income_this_period
      @qc_b2_pensionable = pensionable_non_periodic_income_this_period
      @qc_a5 = ytd_contributions
    end

    def translate
      {
        qc_s3: (@qc_s3 * 100).to_d,
        qc_s3_periodic: (@qc_s3 * 100).to_d - (@qc_b2_pensionable * 100).to_d,
        qc_b2_pensionable: (@qc_b2_pensionable * 100).to_d,
        qc_a5: (@qc_a5 * 100).to_d
      }
    end
  end
end
