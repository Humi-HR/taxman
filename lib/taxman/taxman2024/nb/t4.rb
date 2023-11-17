# frozen_string_literal: true

module Taxman2024
  module Nb
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0940.to_d
      DEFAULT_TD1 = 12_458_00.to_d

      RATES_AND_CONSTANTS = {
        47_715_00.to_d => [LOWEST_RATE, 0.0.to_d],
        95_431_00.to_d => [0.1400, 2_195_00.to_d],
        176_756_00.to_d => [0.1600, 4_104_00.to_d],
        BigDecimal("Infinity") => [0.1950, 10_290_00.to_d]
      }.freeze
    end
  end
end
