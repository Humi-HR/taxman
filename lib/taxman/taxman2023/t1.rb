# frozen_string_literal: true

module Taxman2023
  # Calculates the T1 factor from T3
  # Note: We do not support LCF
  class T1 < Factor
    def self.params
      %i[t3 province]
    end
    attr_reader(*params)

    # Note that we do not support LCF
    def amount
      if province == Taxman::QC
        t3 - (0.165 * t3)
      else
        t3
      end
    end
  end
end
