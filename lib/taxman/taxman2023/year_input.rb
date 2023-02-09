# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
module Taxman2023
  # This input collects the ytd and general inputs
  class YearInput
    def initialize(
      ytd_bonus:,
      pay_periods:,
      f5b_ytd:,
      employer_ei_multiple: 1.4,
      annual_deductions: 0, # F1
      ytd_rsp_bonus_deductions: 0, # F4
      other_federal_deductions: 0, # K3
      other_provincial_deductions: 0 # K3P
    )
      @b1 = ytd_bonus
      @f1 = annual_deductions
      @f4 = ytd_rsp_bonus_deductions
      @p = pay_periods
      @f5b_ytd = f5b_ytd
      @employer_ei_multiple = employer_ei_multiple
      @k3 = other_federal_deductions
      @k3p = other_provincial_deductions
    end

    def translate
      {
        b1: (@b1 * 100).to_d,
        f1: (@f1 * 100).to_d,
        f4: (@f4 * 100).to_d,
        p: @p,
        f5b_ytd: (@f5b_ytd * 100).to_d,
        employer_ei_multiple: @employer_ei_multiple.to_d,
        k3: (@k3 * 100).to_d,
        k3p: (@k3p * 100).to_d
      }
    end
  end
end
# rubocop:enable Metrics/ParameterLists