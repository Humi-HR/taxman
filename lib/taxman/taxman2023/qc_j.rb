# frozen_string_literal: true

module Taxman2023
  # Deductions shown on line 19 of form TP-1015.3-V
  class QcJ < Factor
    def self.params
      %i[p j3 pr]
    end
    attr_reader *params

    def amount
      return j3 if p == pr # first pay period in year

      (p * j3) / pr
    end
  end
end
