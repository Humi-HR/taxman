# frozen_string_literal: true

module Taxman2024
  module Pe
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0965.to_d
      DEFAULT_TD1 = 13_500_00.to_d

      RATES_AND_CONSTANTS = {
        32_656_00.to_d => [LOWEST_RATE, 0.0.to_d],
        64_313_00.to_d => [0.1363, 1_300_00.to_d],
        105_000_00.to_d => [0.1665, 3_242_00.to_d],
        140_000_00.to_d => [0.1800, 4_659_00.to_d],
        BigDecimal("Infinity") => [0.1875, 5_709_00.to_d]
      }.freeze
    end
  end
end
