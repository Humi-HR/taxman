# frozen_string_literal: true

module Taxman2024
  # Calculates the final term of the annualized income in the presence of a bonus
  class YtdBonusTerm < Factor
    def self.params
      %i[b1 f4 f5b_ytd]
    end
    attr_reader(*params)

    def amount
      b1 - f4 - f5b_ytd
    end
  end
end
