# frozen_string_literal: true

module Taxman2024
  module Nl
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0870.to_d
      DEFAULT_TD1 = 10_818_00.to_d

      RATES_AND_CONSTANTS = {
        43_198_00.to_d => [LOWEST_RATE, 0.0.to_d],
        86_395_00.to_d => [0.1450, 2_505_00.to_d],
        154_244_00.to_d => [0.1580, 3_629_00.to_d],
        215_943_00.to_d => [0.1780, 6_713_00.to_d],
        275_870_00.to_d => [0.1980, 11_032_00.to_d],
        551_739_00.to_d => [0.2080, 13_791_00.to_d],
        1_103_478_00.to_d => [0.2130, 16_550_00.to_d],
        BigDecimal("Infinity") => [0.2180, 22_067_00.to_d]
      }.freeze
    end
  end
end
