# frozen_string_literal: true

module Taxman2024
  module Sk
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1050.to_d
      DEFAULT_TD1 = 18_491_00.to_d

      RATES_AND_CONSTANTS = {
        52_057_00.to_d => [LOWEST_RATE, 0.0.to_d],
        148_734_00.to_d => [0.1250, 1_041_00.to_d],
        BigDecimal("Infinity") => [0.1450, 4_016_00.to_d]
      }.freeze
    end
  end
end
