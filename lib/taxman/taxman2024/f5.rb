# frozen_string_literal: true

module Taxman2024
  # Calculates the F5 factor
  class F5 < Factor
    def self.params
      %i[c]
    end
    attr_reader(*params)

    def amount
      c * (BigDecimal("0.01") / BigDecimal("0.0595"))
    end
  end
end
