# frozen_string_literal: true

module Taxman2023
  module Nu
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.04.to_d
      DEFAULT_TD1 = 17_925_00.to_d

      RATES_AND_CONSTANTS = {
        50_877_00.to_d => [LOWEST_RATE, 0.0.to_d],
        101_754_00.to_d => [0.0700, 1_526_00.to_d],
        165_429_00.to_d => [0.0900, 3_561_00.to_d],
        BigDecimal("Infinity") => [0.1150, 7_697_00.to_d]
      }.freeze
    end
  end
end
