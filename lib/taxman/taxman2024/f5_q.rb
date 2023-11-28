# frozen_string_literal: true

module Taxman2024
  # Calculates the F5Q factor
  class F5Q < Factor
    def self.params
      %i[qc_c c2]
    end
    attr_reader(*params)

    def amount
      (qc_c * (BigDecimal("0.01") / BigDecimal("0.0640"))) + c2
    end
  end
end
