# frozen_string_literal: true

module Taxman2023
  module Qpp
    # Bag to hold all of the QPP constants for 2023
    MAXIMUM_PENSIONABLE = 66_600_00.to_d
    MAX = 4_038_40.to_d
    BASIC_EXEMPTION = 3_500_00.to_d
    RATE = 0.0640.to_d

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
