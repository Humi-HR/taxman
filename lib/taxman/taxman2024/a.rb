# frozen_string_literal: true

module Taxman2024
  # This calculates the total annual taxable income from the income for the period
  class A < Factor
    def self.params
      %i[p i f f2 f5a u1 hd f1]
    end
    attr_reader(*params)

    def amount
      a = (p * (i - f - f2 - f5a - u1)) - hd - f1

      return 0 if a <= 0

      a
    end
  end
end
