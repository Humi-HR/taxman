# frozen_string_literal: true

module Taxman2023
  # Calculates the final term of the annualized income in the presence of a bonus
  class YtdBonusTerm
    attr_reader :b1, :f4, :f5b_ytd

    def initialize(b1:, f4:, f5b_ytd:)
      @b1 = b1.to_d
      @f4 = f4.to_d
      @f5b_ytd = f5b_ytd.to_d
    end

    def self.params
      %i[b1 f4 f5b_ytd]
    end

    def amount
      b1 - f4 - f5b_ytd
    end
  end
end
