# frozen_string_literal: true

module Taxman2023
  module Ab
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1.to_d
      DEFAULT_TD1 = 21_003_00.to_d

      RATES_AND_CONSTANTS = {
        142_292_00.to_d => [LOWEST_RATE, 0.0.to_d],
        170_751_00.to_d => [0.12, 2_846_00.to_d],
        227_668_00.to_d => [0.13, 4_553_00.to_d],
        341_502_00.to_d => [0.14, 6_830_00.to_d],
        BigDecimal("Infinity") => [0.15, 10_245_00.to_d]
      }.freeze
    end
  end
end
