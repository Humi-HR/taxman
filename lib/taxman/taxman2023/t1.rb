# frozen_string_literal: true

module Taxman2023
  # Calculates the T1 factor from T3
  # Note: We do not support LCF
  class T1
    attr_reader :t3, :province

    def initialize(t3:, province:)
      @t3 = t3
      @province = province
    end

    def self.params
      %i[t3 province]
    end

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
