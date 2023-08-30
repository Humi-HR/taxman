# frozen_string_literal: true

# rubocop:disable Metrics/ParameterLists
module Taxman2023
  # This input collects the factors specific to the current pay period
  class PeriodInput
    def initialize(
      taxable_periodic_income:,
      taxable_non_periodic_income:,
      province:,
      rsp_deductions: 0,
      alimony: 0,
      rsp_deductions_from_bonus: 0,
      previous_taxable_periodic_income: 0,
      union_dues: 0
    )
      @i = taxable_periodic_income
      @previous_i = previous_taxable_periodic_income
      @b = taxable_non_periodic_income
      @f = rsp_deductions
      @f2 = alimony
      @f3 = rsp_deductions_from_bonus
      @u1 = union_dues
      @province = province
      @qc_g = @qc_d = taxable_periodic_income
      @qc_b2 = taxable_non_periodic_income
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def translate
      {
        i: (@i * 100).to_d,
        previous_i: (@previous_i * 100).to_d,
        b: (@b * 100).to_d,
        f: (@f * 100).to_d,
        f2: (@f2 * 100).to_d,
        f3: (@f3 * 100).to_d,
        u1: (@u1 * 100).to_d,
        province: @province.strip.upcase,
        qc_g: (@qc_g * 100).to_d,
        qc_d: (@qc_d * 100).to_d,
        qc_b2: (@qc_b2 * 100).to_d
      }
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end
end
# rubocop:enable Metrics/ParameterLists
