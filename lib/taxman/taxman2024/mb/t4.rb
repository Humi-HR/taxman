# frozen_string_literal: true

module Taxman2024
  module Mb
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.1080.to_d
      DEFAULT_TD1 = 19_145_00.to_d

      RATES_AND_CONSTANTS = {
        36_842_00.to_d => [LOWEST_RATE, 0.0.to_d],
        79_625_00.to_d => [0.1275, 718_00.to_d],
        BigDecimal("Infinity") => [0.1740, 4_421_00.to_d]
      }.freeze
    end
  end
end
