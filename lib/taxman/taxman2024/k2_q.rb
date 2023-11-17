# frozen_string_literal: true

module Taxman2024
  # Calculates the k2q factor for Quebec
  class K2Q < K2Generic
    def self.params
      %i[p pm d1 d b_pensionable b1_pensionable qc_a5 qc_a6 pi_periodic
         ie_periodic p b_insurable b1_insurable]
    end
    attr_reader(*params)

    def amount
      pension_portion + qc_ei_portion + qc_ie_portion
    end

    def pension_portion
      [qpp_credit, Qpp::MAX_CREDIT * (pm / 12)].min * 0.15
    end

    def qc_ei_portion
      [ei_credit, Ei::QC_EI_MAX * (pm / 12)].min * 0.15
    end

    def qc_ie_portion
      [ie_qpip_credit, Qpip::EMPLOYEE_MAX * (pm / 12)].min * 0.15
    end
  end
end
