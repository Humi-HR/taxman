# frozen_string_literal: true

module Taxman2024
  module Qpip
    # Bag to hold all of the CPP constants for 2024
    MAXIMUM_INSURABLE = 94_000_00.to_d
    EMPLOYEE_RATE = 0.00494.to_d
    EMPLOYEE_MAX = MAXIMUM_INSURABLE * EMPLOYEE_RATE
    EMPLOYER_RATE = 0.00692.to_d
    EMPLOYER_MAX = MAXIMUM_INSURABLE * EMPLOYER_RATE

    # Helper method to get the constants as a hash
    class Constants
      def self.to_h
        {
          qpip_employee_rate: EMPLOYEE_RATE,
          qpip_employer_rate: EMPLOYER_RATE,
          qpip_maximum_insurable: MAXIMUM_INSURABLE,
          qpip_employee_max: EMPLOYEE_MAX,
          qpip_employer_max: EMPLOYER_MAX
        }
      end
    end
  end
end
