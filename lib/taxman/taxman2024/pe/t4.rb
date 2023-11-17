# frozen_string_literal: true

module Taxman2024
  module Pe
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0980.to_d
      DEFAULT_TD1 = 12_000_00.to_d

      RATES_AND_CONSTANTS = {
        31_984_00.to_d => [LOWEST_RATE, 0.0.to_d],
        63_969_00.to_d => [0.1380, 1_279_00.to_d],
        BigDecimal("Infinity") => [0.1670, 3_134_00.to_d]
      }.freeze
    end
  end
end
