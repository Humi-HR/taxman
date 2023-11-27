# frozen_string_literal: true

module Taxman2024
  module Nb
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0940.to_d
      DEFAULT_TD1 = 13_044_00.to_d

      RATES_AND_CONSTANTS = {
        49_958_00.to_d => [LOWEST_RATE, 0.0.to_d],
        99_916_00.to_d => [0.1400, 2_298_00.to_d],
        185_064_00.to_d => [0.1600, 4_296_00.to_d],
        BigDecimal("Infinity") => [0.1950, 10_774_00.to_d]
      }.freeze
    end
  end
end
