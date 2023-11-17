# frozen_string_literal: true

module Taxman2023
  # Calculates the middle term of the annualized income in the presence of a bonus
  class CurrentBonusTerm < Factor
    def self.params
      %i[b f3 f5b]
    end
    attr_reader(*params)

    def amount
      b - f3 - f5b
    end
  end
end
