# frozen_string_literal: true

module Taxman2023
  # Deduction for employment income
  class QcH < Factor
    def self.params
      %i[d p]
    end
    attr_reader *params

    def amount
      [(0.06 * d), 1_315 * 100].min / p
    end
  end
end
