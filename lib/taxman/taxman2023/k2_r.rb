# frozen_string_literal: true

module Taxman2023
  # Calculates the k2R factor for Quebec
  class K2R < K2Generic
    def self.params
      %i[p dq pm ei ie d1 d b_pensionable b1_pensionable qc_a5 qc_a6
         pi_periodic ie ie_periodic p province b_insurable b1_insurable]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion
    end

    def pension_portion
      [
        p * cpp_portion * (Cpp::LOWER_RATE / Cpp::RATE),
        (Cpp::MAX_CREDIT * (pm / 12)) -
          (dq * (Cpp::LOWER_RATE / Qpp::RATE)) +
          (dq * (Qpp::LOWER_RATE / Qpp::RATE))
      ].min * 0.15
    end

    def qc_ei_portion
      [ei_credit, Ei::QC_EI_MAX * (pm / 12)].min * 0.15
    end
  end
end
