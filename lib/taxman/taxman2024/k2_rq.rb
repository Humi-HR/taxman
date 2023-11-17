# frozen_string_literal: true

module Taxman2024
  # Calculates the k2rq factor for Quebec
  class K2RQ < K2Generic
    def self.params
      %i[p pm ei ie d1 d b_pensionable b1_pensionable qc_a5 qc_a6
         pi_periodic ie ie_periodic p province b_insurable b1_insurable]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion + qc_ie_portion
    end

    def pension_portion
      [
        p * qpp_portion * (Qpp::LOWER_RATE / Qpp::RATE),
        (Qpp::MAX_CREDIT * (pm / 12)) -
          (d * (Qpp::LOWER_RATE / Cpp::RATE)) +
          (d * (Cpp::LOWER_RATE / Cpp::RATE))
      ].min * 0.15
    end

    def qc_ei_portion
      [ei_credit, Ei::QC_EI_MAX * (pm / 12)].min * 0.15
    end

    def qc_ie_portion
      [ie_qpip_credit, Qpip::EMPLOYEE_MAX * (pm / 12)].min * 0.15
    end
  end
end
