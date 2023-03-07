# frozen_string_literal: true

module Taxman2023
  # This input collects the factors from the TD1 form
  class Td1Input
    # If nil is passed for either of the personal amounts, we
    # will calculate them using the standard formula
    # rubocop:disable Metrics/ParameterLists
    def initialize(
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      federal_personal_amount_offset: 0,
      provincial_personal_amount_offset: 0,
      deduction_for_zone: 0,
      additional_tax_deductions: 0
    )
      @tc = federal_personal_amount
      @tcp = provincial_personal_amount
      @tc_offset = federal_personal_amount_offset
      @tcp_offset = provincial_personal_amount_offset
      @hd = deduction_for_zone
      @l = additional_tax_deductions
    end
    # rubocop:enable Metrics/ParameterLists

    def translate
      {
        tc: tc,
        tcp: tcp,
        tc_offset: (@tc_offset * 100).to_d,
        tcp_offset: (@tcp_offset * 100).to_d,
        hd: (@hd * 100).to_d,
        l: (@l * 100).to_d
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
