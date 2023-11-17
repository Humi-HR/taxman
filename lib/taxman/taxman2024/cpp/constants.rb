# frozen_string_literal: true

module Taxman2024
  module Cpp
    # Bag to hold all of the CPP constants for 2024
    MAXIMUM_PENSIONABLE = 66_600_00.to_d
    MAX = 3_754_45.to_d
    BASIC_EXEMPTION = 3_500_00.to_d
    RATE = 0.0595.to_d
    LOWER_RATE = 0.0495.to_d
    MAX_CREDIT = 3_123_45.to_d

    # Helper method to get the constants as a hash
    class Constants
      def self.to_h
        {
          cpp_basic_exemption: BASIC_EXEMPTION / 100,
          cpp_employee_rate: RATE,
          cpp_employer_matching: BigDecimal("1.0"),
          cpp_maximum_pensionable: MAXIMUM_PENSIONABLE / 100
        }
      end
    end
  end
end
