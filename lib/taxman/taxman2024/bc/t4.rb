# frozen_string_literal: true

module Taxman2024
  module Bc
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0506.to_d
      DEFAULT_TD1 = 12_580_00.to_d

      RATES_AND_CONSTANTS = {
        47_937_00.to_d => [LOWEST_RATE, 0.0.to_d],
        95_875_00.to_d => [0.0770, 1_266_00.to_d],
        110_076_00.to_d => [0.1050, 3_950_00.to_d],
        133_664_00.to_d => [0.1229, 5_920_00.to_d],
        181_232_00.to_d => [0.1470, 9_142_00.to_d],
        252_752_00.to_d => [0.1680, 12_948_00.to_d],
        BigDecimal("Infinity") => [0.2050, 22_299_00.to_d]
      }.freeze
    end
  end
end
