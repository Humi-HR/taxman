# frozen_string_literal: true

module Taxman2023
  # Calculates the F5Q factor
  class F5Q
    attr_reader :qc_c

    def initialize(qc_c:)
      @qc_c = qc_c
    end

    def self.params
      [:qc_c]
    end

    def amount
      qc_c * (BigDecimal("0.01") / BigDecimal("0.0640"))
    end
  end
end
