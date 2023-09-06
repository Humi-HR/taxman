# frozen_string_literal: true

module Taxman2023
  # Calculates the k2p factor for Quebec
  class K2Q < Factor
    def self.params
      %i[p c pm ei ie]
    end
    attr_reader(*params)

    def amount
      [pension_amount + employment_insurance_amount + insurable_earnings_amount]
    end

    def pension_amount
      [
        p * c * (lower_qpp_rate / higher_qpp_rate),
        maximum_pension_rate * (pm / 12)
      ].min * 0.15
    end

    def employment_insurance_amount
      [
        p * ei,
        maximum_employment_insurance
      ].min * 0.15
    end

    def insurable_earnings_amount
      [
        p * ie * 0.00494,
        maximum_insurable_earnings
      ].min * 0.15
    end

    def maximum_pension_rate
      3407.40
    end

    def maximum_employment_insurance
      781.05
    end

    def maximum_insurable_earnings
      449.54
    end

    def lower_qpp_rate
      0.0540
    end

    def higher_qpp_rate
      0.0640
    end
  end
end
