# frozen_string_literal: true

module Taxman2023
  # Calculates the generic k2 factor
  class K2Generic
    attr_reader :i, # Income in the period
                :b, # Bonus in the period
                :b1, # Bonus YTD
                :p # Number of periods

    def initialize(
      i:,
      b:,
      b1:,
      p:
    )
      @i = i.to_d
      @b = b.to_d
      @b1 = b1.to_d
      @p = p
    end

    def self.params
      %i[i b b1 p]
    end

    def rate
      0.0505 # Ontario lol
    end

    def amount
      ([cpp_credit, max_cpp_credit].min * rate) + ([ei_credit, max_ei_credit].min * rate)
    end

    def cpp_credit
      p * cpp_portion * lower_cpp_rate / higher_cpp_rate
    end

    def max_cpp_credit
      3_123_45.to_d
    end

    def cpp_portion
      ((i + ((b + b1) / p)) - (3_500_00.to_d / p)) * 0.0595
    end

    def ei_credit
      p * ei_portion
    end

    def max_ei_credit
      1_002_45.to_d
    end

    def ei_portion
      (i + ((b + b1) / p)) * 0.0163
    end

    def lower_cpp_rate
      0.0495
    end

    def higher_cpp_rate
      0.0595
    end
  end
end
