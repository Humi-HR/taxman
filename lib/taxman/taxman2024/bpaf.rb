# frozen_string_literal: true

module Taxman2024
  # Calculates the basic personal federal tax exemption
  class Bpaf
    LOWER_THRESHOLD = 165_430_00.to_d
    UPPER_THRESHOLD = 235_675_00.to_d

    MAX_AMOUNT = 15_000_00.to_d
    MIN_AMOUNT = 13_521_00.to_d
    attr_reader :ni

    def initialize(a:, hd:)
      @ni = a.to_d + hd.to_d
    end

    def amount
      return MAX_AMOUNT if ni <= LOWER_THRESHOLD
      return MIN_AMOUNT if ni >= UPPER_THRESHOLD

      MAX_AMOUNT - ((ni - LOWER_THRESHOLD) * (1_479_00.to_d / 70_245_00.to_d))
    end
  end
end
