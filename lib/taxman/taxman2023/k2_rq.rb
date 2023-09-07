# frozen_string_literal: true

module Taxman2023
  # Calculates the k2rq factor for Quebec
  class K2RQ < K2Generic
    def self.params
      %i[p c pm d ei ie]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion + qc_ie_portion
    end

    def pension_portion
      [
        p * c * (lower_cpp_rate / higher_cpp_rate),
        (max_qpp_credit * (pm / 12)) -
          (d * (higher_qpp_rate / higher_cpp_rate)) +
          (d * (lower_cpp_rate / higher_cpp_rate))
      ].min * 0.15
    end
  end
end
