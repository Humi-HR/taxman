# frozen_string_literal: true

module Taxman2023
  # Calculates the generic k2 factor
  class K2Generic < Factor
    def qc_ei_portion
      [
        p * ei,
        qc_ei_max
      ].min * 0.15
    end

    def qc_ie_portion
      [
        p * ie * lower_cpp_rate,
        qpip_max
      ].min * 0.15
    end

    # Constant helpers
    def max_ei_credit
      Ei::EI_MAX
    end

    def max_cpp_credit
      Cpp::MAX_CREDIT
    end

    def max_qpp_credit
      Qpp::MAX_CREDIT
    end

    def lower_cpp_rate
      Cpp::LOWER_RATE
    end

    def higher_cpp_rate
      Cpp::RATE
    end

    def lower_qpp_rate
      Qpp::LOWER_RATE
    end

    def higher_qpp_rate
      Qpp::RATE
    end

    def qc_ei_max
      Ei::QC_EI_MAX
    end

    def qpip_max
      Qpp::QPIP_MAX
    end
  end
end
