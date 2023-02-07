# frozen_string_literal: true

module Taxman2023
  module On
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0505.to_d
      DEFAULT_TD1 = 11_865_00.to_d

      RATES_AND_CONSTANTS = {
        49_231_00.to_d => [LOWEST_RATE, 0.0.to_d],
        98_463_00.to_d => [0.0915.to_d, 2_018_00.to_d],
        150_000_00.to_d => [0.1116.to_d, 3_998_00.to_d],
        220_000_00.to_d => [0.1216.to_d, 5_498_00.to_d],
        BigDecimal("Infinity") => [0.1316.to_d, 7_698_00.to_d]
      }.freeze
    end
  end
end
