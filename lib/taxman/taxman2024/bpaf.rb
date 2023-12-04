# frozen_string_literal: true

module Taxman2024
  # Calculates the basic personal federal tax exemption
  class Bpaf
    LOWER_THRESHOLD = 173_205_00.to_d
    UPPER_THRESHOLD = 246_752_00.to_d

    MAX_AMOUNT = 15_705_00.to_d
    MIN_AMOUNT = 14_156_00.to_d
    attr_reader :ni

    def initialize(a:, hd:)
      @ni = a.to_d + hd.to_d
    end

    def amount
      return MAX_AMOUNT if ni <= LOWER_THRESHOLD
      return MIN_AMOUNT if ni >= UPPER_THRESHOLD

      MAX_AMOUNT - ((ni - LOWER_THRESHOLD) * (1_549_00.to_d / 73_547_00.to_d))
    end
  end
end
