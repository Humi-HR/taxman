# frozen_string_literal: true

module Taxman2023
  # This input collects the ytd and general inputs
  class YearInput
    def initialize(
      ytd_bonus:,
      pay_periods:,
      f5b_ytd:,
      annual_deductions: 0, # F1
      ytd_rsp_bonus_deductions: 0 # F4
    )
      @b1 = ytd_bonus
      @f1 = annual_deductions
      @f4 = ytd_rsp_bonus_deductions
      @p = pay_periods
      @f5b_ytd = f5b_ytd
    end

    def translate
      {
        b1: (@b1 * 100).to_d,
        f1: (@f1 * 100).to_d,
        f4: (@f4 * 100).to_d,
        p: @p,
        f5b_ytd: (@f5b_ytd * 100).to_d
      }
    end
  end
end
