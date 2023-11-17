# frozen_string_literal: true

module Taxman2024
  # Calculates the provincial personal amount for NS because they just have to be different
  class Bpans
    attr_reader :a

    MAX_VALUE = 11_481_00.to_d
    MIN_VALUE = 8_481_00.to_d

    def initialize(a:)
      @a = a
    end

    def amount
      return MAX_VALUE if a <= 25_000_00.to_d
      return MIN_VALUE if a >= 75_000_00.to_d

      MAX_VALUE - ((a - 25_000_00) * 0.06)
    end
  end
end
