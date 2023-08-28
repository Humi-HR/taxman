# frozen_string_literal: true

module Taxman2023
  # Annual deductions that we authorized after the individual completed form TP-1016-V
  class QcJ1 < Factor
    def self.params
      %i[p j2 pr]
    end
    attr_reader *params

    def amount
      return j2 if p == pr # first pay period in year

      (p * j2) / pr
    end
  end
end
