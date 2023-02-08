# frozen_string_literal: true

module Taxman2023
  # Calculates the K2 factor for federal income tax
  class K2
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

    def amount
      K2Generic.new(
        i: i,
        b: b,
        b1: b1,
        p: p,
        rate: T3::LOWEST_RATE
      ).amount
    end
  end
end
