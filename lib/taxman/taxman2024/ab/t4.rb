# frozen_string_literal: true

module Taxman2024
  module Ab
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1.to_d
      DEFAULT_TD1 = 21_885_00.to_d

      RATES_AND_CONSTANTS = {
        148_289_00.to_d => [LOWEST_RATE, 0.0.to_d],
        177_922_00.to_d => [0.12, 2_965_00.to_d],
        237_230_00.to_d => [0.13, 4_745_00.to_d],
        355_845_00.to_d => [0.14, 7_117_00.to_d],
        BigDecimal("Infinity") => [0.15, 10_675_00.to_d]
      }.freeze
    end
  end
end
