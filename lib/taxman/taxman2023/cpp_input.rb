# frozen_string_literal: true

module Taxman2023
  # This input collects the factors specific to cpp calculation
  class CppInput
    def initialize(pensionable_income_this_period:,
                   ytd_contributions:,
                   contribution_months_this_year:,
                   pensionable_non_periodic_income_this_period: 0)
      @pi = pensionable_income_this_period
      @b_pensionable = pensionable_non_periodic_income_this_period
      @d = ytd_contributions
      @pm = contribution_months_this_year
    end

    def translate
      {
        pi: (@pi * 100).to_d,
        b_pensionable: (@b_pensionable * 100).to_d,
        d: (@d * 100).to_d,
        pm: @pm
      }
    end
  end
end
