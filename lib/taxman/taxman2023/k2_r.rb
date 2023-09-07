# frozen_string_literal: true

module Taxman2023
  # Calculates the k2R factor for Quebec
  class K2R < K2Generic
    def self.params
      %i[p c pm dq ei]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion
    end

    def pension_portion
      [
        p * c * (lower_cpp_rate / higher_cpp_rate),
        (max_cpp_credit * (pm / 12)) -
          (dq * (lower_cpp_rate / higher_qpp_rate)) +
          (dq * (lower_qpp_rate / higher_qpp_rate))
      ].min * 0.15
    end
  end
end
