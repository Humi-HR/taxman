# frozen_string_literal: true

module Taxman2023
  # Calculates the F5 factor
  class F5
    attr_reader :c

    def initialize(c:)
      @c = c
    end

    def self.params
      [:c]
    end

    def amount
      c * (BigDecimal("0.01") / BigDecimal("0.0595"))
    end
  end
end
