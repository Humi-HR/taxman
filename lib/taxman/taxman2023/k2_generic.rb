# frozen_string_literal: true

module Taxman2023
  # Calculates the generic k2 factor
  class K2Generic < Factor
    def qpp_credit
      # If the contribution has already been reached, return max
      return Qpp::MAX_CREDIT if @qc_a5 >= Qpp::MAX_CREDIT

      p * qpp_portion * Qpp::LOWER_RATE / Qpp::RATE
    end

    def qpp_portion
      [
        ((pi_periodic + ((b_pensionable + b1_pensionable) / p)) - (Qpp::BASIC_EXEMPTION / p)) * Qpp::RATE,
        0
      ].max
    end

    def cpp_credit
      # If the contribution has already been reached, return max
      return Cpp::MAX_CREDIT if @d >= Cpp::MAX_CREDIT

      p * cpp_portion * Cpp::LOWER_RATE / Cpp::RATE
    end

    def cpp_portion
      [
        ((pi_periodic + ((b_pensionable + b1_pensionable) / p)) - (Cpp::BASIC_EXEMPTION / p)) * Cpp::RATE,
        0
      ].max
    end

    def ei_credit
      # If the contribution has already been reached, return max
      return Ei::QC_EI_MAX if @d1 >= Ei::QC_EI_MAX

      p * ei_portion
    end

    def ei_portion
      (ie_periodic + ((b_insurable + b1_insurable) / p)) * Ei::QC_EMPLOYEE_RATE
    end

    def ie_qpip_credit
      # If the contribution has already been reached, return max
      return Qpip::EMPLOYEE_MAX if @qc_a6 >= Qpip::EMPLOYEE_MAX

      p * ie_qpip_portion
    end

    def ie_qpip_portion
      (ie_periodic + ((b_insurable + b1_insurable) / p)) * Qpip::EMPLOYEE_RATE
    end
  end
end
