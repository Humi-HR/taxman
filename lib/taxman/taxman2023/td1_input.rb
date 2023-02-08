# frozen_string_literal: true

module Taxman2023
  # This input collects the factors from the TD1 form
  class Td1Input
    # If nil is passed for either of the personal amounts, we
    # will calculate them using the standard formula
    def initialize(
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      deduction_for_zone: 0,
      additional_tax_deductions: 0
    )
      @tc = federal_personal_amount
      @tcp = provincial_personal_amount
      @hd = deduction_for_zone
      @l = additional_tax_deductions
    end

    def translate
      {
        tc: tc,
        tcp: tcp,
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
