# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
module Taxman2023
  # This input collects the factors specific to the current pay period
  class PeriodInput
    def initialize(
      taxable_periodic_income:,
      taxable_non_periodic_income:,
      rsp_deductions: 0,
      alimony: 0,
      rsp_deductions_from_bonus: 0,
      union_dues: 0
    )
      @i = taxable_periodic_income
      @b = taxable_non_periodic_income
      @f = rsp_deductions
      @f2 = alimony
      @f3 = rsp_deductions_from_bonus
      @u1 = union_dues
    end

    def translate
      {
        i: (@i * 100).to_d,
        b: (@b * 100).to_d,
        f: (@f * 100).to_d,
        f2: (@f2 * 100).to_d,
        f3: (@f3 * 100).to_d,
        u1: (@u1 * 100).to_d
      }
    end
  end
end
# rubocop:enable Metrics/ParameterLists
