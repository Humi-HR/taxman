# frozen_string_literal: true

module Taxman2023
  # Calculates the middle term of the annualized income in the presence of a bonus
  class CurrentBonusTerm
    attr_reader :b, :f3, :f5b

    def initialize(b:, f3:, f5b:)
      @b = b.to_d
      @f3 = f3.to_d
      @f5b = f5b.to_d
    end

    def amount
      b - f3 - f5b
    end
  end
end
