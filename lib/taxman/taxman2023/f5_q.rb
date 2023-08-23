# frozen_string_literal: true

module Taxman2023
  # Calculates the F5Q factor
  class F5Q
    attr_reader :c

    def initialize(c:)
      @c = c
    end

    def self.params
      [:c]
    end

    def amount
      c * (BigDecimal("0.01") / BigDecimal("0.0640"))
    end
  end
end
