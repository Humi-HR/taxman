# frozen_string_literal: true

module Taxman2022
  module Ei
    EI_MAX = 952_74.to_d
    MAXIMUM_INSURABLE = 60_300_00.to_d
    EMPLOYEE_RATE = 0.0158.to_d
    EMPLOYER_MATCHING = 1.4.to_d

    # A bag to hold the ei constants for 2022
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
