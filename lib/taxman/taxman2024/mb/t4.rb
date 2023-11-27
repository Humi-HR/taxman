# frozen_string_literal: true

module Taxman2024
  module Mb
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1080.to_d
      DEFAULT_TD1 = 15_780_00.to_d

      RATES_AND_CONSTANTS = {
        47_000_00.to_d => [LOWEST_RATE, 0.0.to_d],
        100_000_00.to_d => [0.1275, 917_00.to_d],
        BigDecimal("Infinity") => [0.1740, 5_567_00.to_d]
      }.freeze
    end
  end
end
