# frozen_string_literal: true

module Taxman2024
  module Bc
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0506.to_d
      DEFAULT_TD1 = 11_981_00.to_d

      RATES_AND_CONSTANTS = {
        45_654_00.to_d => [LOWEST_RATE, 0.0.to_d],
        91_310_00.to_d => [0.0770, 1_205_00.to_d],
        104_835_00.to_d => [0.1050, 3_762_00.to_d],
        127_299_00.to_d => [0.1229, 5_638_00.to_d],
        172_602_00.to_d => [0.1470, 8_706_00.to_d],
        240_716_00.to_d => [0.1680, 12_331_00.to_d],
        BigDecimal("Infinity") => [0.2050, 21_238_00.to_d]
      }.freeze
    end
  end
end
