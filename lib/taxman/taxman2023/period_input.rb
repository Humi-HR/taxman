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
      union_dues: 0,
      qc_taxable_periodic_income: 0,
      qc_gross_pensionable_earnings: 0,
      qc_lump_sum_payments: 0,
      qc_authorized_deductions: 0,
      qc_line_19_deductions: 0
    )
      @i = taxable_periodic_income
      @previous_i = previous_taxable_periodic_income
      @b = taxable_non_periodic_income
      @f = rsp_deductions
      @f2 = alimony
      @f3 = rsp_deductions_from_bonus
      @u1 = union_dues
      @province = province
      @qc_d = qc_taxable_periodic_income
      @qc_s3 = qc_gross_pensionable_earnings
      @qc_b2 = qc_lump_sum_payments
      @qc_j2 = qc_authorized_deductions
      @qc_j3 = qc_line_19_deductions
    end

    def translate
      {
        i: (@i * 100).to_d,
        previous_i: (@previous_i * 100).to_d,
        b: (@b * 100).to_d,
        f: (@f * 100).to_d,
        f2: (@f2 * 100).to_d,
        f3: (@f3 * 100).to_d,
        u1: (@u1 * 100).to_d,
        province: @province.strip.upcase
        qc_d: (@qc_d * 100).to_d,
        qc_s3: (@qc_s3 * 100).to_d,
        qc_b2: (@qc_b2 * 100).to_d,
        qc_j2: (@qc_j2 * 100).to_d,
        qc_j3: (@qc_j3 * 100).to_d,
      }
    end
  end
end
# rubocop:enable Metrics/ParameterLists
