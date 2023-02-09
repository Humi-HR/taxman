# frozen_string_literal: true

module Taxman2023
  module Sk
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1050.to_d
      DEFAULT_TD1 = 17_661_00.to_d

      RATES_AND_CONSTANTS = {
        49_720_00.to_d => [LOWEST_RATE, 0.0.to_d],
        142_058_00.to_d => [0.1250, 994_00.to_d],
        BigDecimal("Infinity") => [0.1450, 3_836_00.to_d]
      }.freeze
    end
  end
end
