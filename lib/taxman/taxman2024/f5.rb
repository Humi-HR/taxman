# frozen_string_literal: true

module Taxman2024
  # Calculates the F5 factor
  class F5 < Factor
    def self.params
      %i[c c2]
    end
    attr_reader(*params)

    def amount
      (c * (BigDecimal("0.01") / BigDecimal("0.0595"))) + c2
    end
  end
end
