# frozen_string_literal: true

module Taxman2023
  # Construct a CppInput and pass it to the calculator
  class CppInput
    def initialize(pensionable_income_this_period:,
                   ytd_contributions:,
                   contribution_months_this_year:)
      @pi = pensionable_income_this_period
      @d = ytd_contributions
      @pm = contribution_months_this_year
    end

    def translate
      {
        pi: (@pi * 100).to_d,
        d: (@d * 100).to_d,
        pm: @pm
      }
    end
  end
end
