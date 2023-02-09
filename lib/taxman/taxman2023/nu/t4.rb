# frozen_string_literal: true

module Taxman2023
  module Nu
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0870.to_d
      DEFAULT_TD1 = 10_382_00.to_d

      RATES_AND_CONSTANTS = {
        41_457_00.to_d => [LOWEST_RATE, 0.0.to_d],
        82_913_00.to_d => [0.1450, 2_405_00.to_d],
        148_027_00.to_d => [0.1580, 3_482_00.to_d],
        207_239_00.to_d => [0.1780, 6_443_00.to_d],
        264_750_00.to_d => [0.1980, 10_588_00.to_d],
        529_500_00.to_d => [0.2080, 13_235_00.to_d],
        1_059_000_00.to_d => [0.2130, 15_883_00.to_d],
        BigDecimal("Infinity") => [0.2180, 21_178_00.to_d]
      }.freeze
    end
  end
end
