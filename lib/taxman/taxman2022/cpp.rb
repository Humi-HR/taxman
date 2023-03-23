# frozen_string_literal: true

module Taxman2022
  module Cpp
    MAXIMUM_PENSIONABLE = 64_900_00.to_d
    MAX = 3_499_80.to_d
    BASIC_EXEMPTION = 3_500_00.to_d
    RATE = 0.0570.to_d

    # A bag to hold the cpp constants for 2022
    class Constants
      def self.to_h
        {
          cpp_maximum_pensionable: MAXIMUM_PENSIONABLE / 100,
          cpp_basic_exemption: BASIC_EXEMPTION / 100,
          cpp_employee_rate: RATE,
          cpp_employer_matching: 1.0
        }
      end
    end
  end
end
