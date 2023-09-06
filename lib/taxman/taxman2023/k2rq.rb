# frozen_string_literal: true

module Taxman2023
  # Calculates the k2p factor for Quebec
  class K2RQ < Factor
    def self.params
      %i[p c pm d ei ie]
    end
    attr_reader(*params)

    def amount
      [
        pension_amount + employment_insurance_amount + insurable_earnings_amount
      ]
    end

    def pension_amount
      [
        p * c * (0.0540 / 0.0640),
        (maxium_pension_rate * (pm / 12)) - (d * (0.0540 / 0.0595)) + (d * (0.0495 / 0.0595))
      ].min * 0.15
    end

    def employment_insurance_amount
      [
        p * ei,
        maximum_ei
      ].min * 0.15
    end

    def insurable_earnings_amount
      [
        p * ie * 0.00494,
        maximum_insurable_earnings
      ].min * 0.15
    end

    def maxium_pension_rate
      3407.40
    end

    def maximum_ei
      781.05
    end

    def maximum_insurable_earnings
      449.54
    end
  end
end
