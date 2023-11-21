# frozen_string_literal: true

module Taxman2024
  # used in C2 calculation
  class W < Factor
    def self.params
      %i[pi_ytd pm]
    end
    attr_reader(*params)

    def amount
      [pi_ytd, Cpp::MAXIMUM_PENSIONABLE * (pm / 12)].max
    end
  end
end
