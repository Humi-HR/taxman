# frozen_string_literal: true

module Taxman2023
  # Calculates the F5Q factor
  class F5Q < Factor
    def self.params
      [:qc_c]
    end
    attr_reader(*params)

    def amount
      qc_c * (BigDecimal("0.01") / BigDecimal("0.0640"))
    end
  end
end
