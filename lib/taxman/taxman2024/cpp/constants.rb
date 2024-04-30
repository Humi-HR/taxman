# frozen_string_literal: true

module Taxman2024
  module Cpp
    # Bag to hold all of the CPP constants for 2024
    MAXIMUM_PENSIONABLE = 68_500_00.to_d
    ADDITIONAL_MAXIMUM_PENSIONABLE = 73_200_00.to_d
    MAX = 3_867_50.to_d
    MAX_ADDITIONAL = 188_00.to_d
    BASIC_EXEMPTION = 3_500_00.to_d
    RATE = 0.0595.to_d
    ADDITIONAL_RATE = 0.04.to_d
    LOWER_RATE = 0.0495.to_d
    MAX_CREDIT = 3_217_50.to_d

    # Helper method to get the constants as a hash
    class Constants
      def self.to_h
        {
          cpp_basic_exemption: BASIC_EXEMPTION / 100,
          cpp_employee_rate: RATE,
          cpp_employer_matching: BigDecimal("1.0"),
          cpp_maximum_pensionable: MAXIMUM_PENSIONABLE / 100,
          cpp2_basic_exemption: BigDecimal("0.0"),
          cpp2_employee_rate: ADDITIONAL_RATE,
          cpp2_employer_matching: BigDecimal("1.0"),
          cpp2_maximum_pensionable: ADDITIONAL_MAXIMUM_PENSIONABLE / 100
        }
      end
    end
  end
end
