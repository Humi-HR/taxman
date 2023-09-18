# frozen_string_literal: true

module Taxman2023
  # Calculates the employee's ei contributions for the period
  class Ei < Factor
    EI_MAX = 1_002_45.to_d
    QC_EI_MAX = 781_05.to_d
    MAXIMUM_INSURABLE = 61_500_00.to_d
    EMPLOYEE_RATE = 0.0163.to_d
    QC_EMPLOYEE_RATE = 0.0127.to_d
    EMPLOYER_MATCHING = 1.4.to_d

    # Helper method to get the constants as a hash
    class Constants
      def self.to_h
        {
          ei_maximum_insurable: MAXIMUM_INSURABLE / 100,
          ei_employer_matching: EMPLOYER_MATCHING,
          ei_employee_rate: EMPLOYEE_RATE
        }
      end
    end

    def self.params
      %i[ie d1 province]
    end
    attr_reader(*params)

    def amount
      [ei_max, ei_calculated].min
    end

    def ei_max
      [ei_maximum - d1, 0].max
    end

    def ei_calculated
      ie * ei_rate
    end

    def ei_maximum
      province == Taxman::QC ? QC_EI_MAX : EI_MAX
    end

    def ei_rate
      province == Taxman::QC ? QC_EMPLOYEE_RATE : EMPLOYEE_RATE
    end
  end
end
