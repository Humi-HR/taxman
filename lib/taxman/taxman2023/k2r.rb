# frozen_string_literal: true

module Taxman2023
  # Calculates the k2p factor for Quebec
  class K2R < Factor
    # attr_reader :p, :c, :pm, :dq, :ei
    def self.params
      %i[p c pm dq ei]
    end
    attr_reader(*params)

    def amount
      [pension_amount + employment_insurance_amount]
    end

    def pension_amount
      [
        p * c * (0.0495 / 0.0595),
        (maxium_pension_rate * (pm / 12)) - (dq * (0.0495 / 0.0640)) + (dq * (0.0540 / 0.0640))
      ].min * 0.15
    end

    def employment_insurance_amount
      [
        p * ei,
        maximum_ei
      ].min * 0.15
    end

    def maxium_pension_rate
      3123.45
    end

    def maximum_ei
      1002.45
    end
  end
end
