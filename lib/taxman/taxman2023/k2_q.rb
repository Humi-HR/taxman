# frozen_string_literal: true

module Taxman2023
  # Calculates the k2q factor for Quebec
  class K2Q < K2Generic
    def self.params
      %i[p c pm ei ie]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion + qc_ie_portion
    end

    def pension_portion
      [
        p * c * (lower_qpp_rate / higher_qpp_rate),
        max_qpp_credit * (pm / 12)
      ].min * 0.15
    end
  end
end
