# frozen_string_literal: true

module Taxman2024
  module Nt
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0590.to_d
      DEFAULT_TD1 = 17_373_00.to_d

      RATES_AND_CONSTANTS = {
        50_597_00.to_d => [LOWEST_RATE, 0.0.to_d],
        101_198_00.to_d => [0.0860, 1_366_00.to_d],
        164_525_00.to_d => [0.1220, 5_009_00.to_d],
        BigDecimal("Infinity") => [0.1405, 8_053_00.to_d]
      }.freeze
    end
  end
end
