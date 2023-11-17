# frozen_string_literal: true

module Taxman2024
  # This input collects the factors from the TD1 form
  class PersonalTaxDeductionsInput
    # If nil is passed for either of the personal amounts, we
    # will calculate them using the standard formula
    def initialize(
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      federal_personal_amount_offset: 0,
      provincial_personal_amount_offset: 0,
      deduction_for_zone: 0,
      additional_tax_deductions: 0,
      tp_1015_line_7_indexed_value_of_personal_tax_credits: 17_183,
      tp_1015_line_9_non_indexed_value_of_personal_tax_credits: 0,
      tp_1015_line_11_additional_source_deductions: 0,
      tp_1015_line_19_deductions: 0,
      tp_1016_annual_deductions: 0
    )
      @tc = federal_personal_amount
      @tcp = provincial_personal_amount
      @tc_offset = federal_personal_amount_offset
      @tcp_offset = provincial_personal_amount_offset
      @hd = deduction_for_zone
      @l = additional_tax_deductions
      @qc_e1 = tp_1015_line_7_indexed_value_of_personal_tax_credits
      @qc_e2 = tp_1015_line_9_non_indexed_value_of_personal_tax_credits
      @qc_l = tp_1015_line_11_additional_source_deductions
      @qc_j = tp_1015_line_19_deductions
      @qc_j1 = tp_1016_annual_deductions
    end

    def translate
      {
        tc: tc,
        tcp: tcp,
        tc_offset: (@tc_offset * 100).to_d,
        tcp_offset: (@tcp_offset * 100).to_d,
        hd: (@hd * 100).to_d,
        l: (@l * 100).to_d,
        qc_e1: (@qc_e1 * 100).to_d,
        qc_e2: (@qc_e2 * 100).to_d,
        qc_j: (@qc_j * 100).to_d,
        qc_j1: (@qc_j1 * 100).to_d, # Not supported in main app
        qc_k1: 0.to_d, # Not supported
        qc_k2: 0.to_d, # Not supported
        qc_q: 0.to_d, # Not supported
        qc_q1: 0.to_d, # Not supported
        qc_l: (@qc_l * 100).to_d
      }
    end

    def tc
      @tc.nil? ? nil : (@tc * 100).to_d
    end

    def tcp
      @tcp.nil? ? nil : (@tcp * 100).to_d
    end
  end
end
