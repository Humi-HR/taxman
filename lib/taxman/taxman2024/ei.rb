# frozen_string_literal: true

module Taxman2024
  # Calculates the employee's ei contributions for the period
  class Ei < Factor
    EI_MAX = 1_049_12.to_d
    QC_EI_MAX = 781_05.to_d
    MAXIMUM_INSURABLE = 63_200_00.to_d
    EMPLOYEE_RATE = 0.0166.to_d
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
      %i[ie ie_ytd d1 province moved_in_or_out_qc]
    end
    attr_reader(*params)

    def amount
      [ei_max, ei_calculated].min
    end

    def ei_max
      [ei_maximum - d1, 0].max
    end

    def ei_calculated
      if moved_in_or_out_qc
        [[MAXIMUM_INSURABLE - ie_ytd, ie].min * ei_rate, 0].max
      else
        ie * ei_rate
      end
    end

    def ei_maximum
      quebec? ? QC_EI_MAX : EI_MAX
    end

    def ei_rate
      quebec? ? QC_EMPLOYEE_RATE : EMPLOYEE_RATE
    end

    def quebec?
      province == Taxman::QC
    end
  end
end
