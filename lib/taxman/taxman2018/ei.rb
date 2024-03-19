# frozen_string_literal: true

module Taxman2018
  module Ei
    EI_MAX = 858_22.to_d
    MAXIMUM_INSURABLE = 51_700_00.to_d
    EMPLOYEE_RATE = 0.0166.to_d
    EMPLOYER_MATCHING = 1.4.to_d

    # A bag to hold the ei constants for 2018
    class Constants
      def self.to_h
        {
          ei_employee_rate: EMPLOYEE_RATE,
          ei_employer_matching: EMPLOYER_MATCHING,
          ei_maximum_insurable: MAXIMUM_INSURABLE / 100
        }
      end
    end
  end
end
