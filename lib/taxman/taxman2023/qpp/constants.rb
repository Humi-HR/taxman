# frozen_string_literal: true

module Taxman2023
  module Qpp
    # Bag to hold all of the QPP constants for 2023
    MAXIMUM_PENSIONABLE = 66_600_00.to_d
    MAX = 4_038_40.to_d
    BASIC_EXEMPTION = 3_500_00.to_d
    RATE = 0.0640.to_d
    LOWER_RATE = 0.0540.to_d
    QPIP_MAX = 449_54.to_d
    MAX_CREDIT = 3_407_40.to_d

    # Helper method to get the constants as a hash
    class Constants
      def self.to_h
        {
          qpp_basic_exemption: BASIC_EXEMPTION / 100,
          qpp_employee_rate: RATE,
          qpp_employer_matching: BigDecimal("1.0"),
          qpp_maximum_pensionable: MAXIMUM_PENSIONABLE / 100
        }
      end
    end
  end
end
