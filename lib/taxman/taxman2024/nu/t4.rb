# frozen_string_literal: true

module Taxman2024
  module Nu
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.04.to_d
      DEFAULT_TD1 = 18_767_00.to_d

      RATES_AND_CONSTANTS = {
        53_268_00.to_d => [LOWEST_RATE, 0.0.to_d],
        106_537_00.to_d => [0.0700, 1_598_00.to_d],
        173_205_00.to_d => [0.0900, 3_729_00.to_d],
        BigDecimal("Infinity") => [0.1150, 8_059_00.to_d]
      }.freeze
    end
  end
end
