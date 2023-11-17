# frozen_string_literal: true

module Taxman2024
  module Nt
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0590.to_d
      DEFAULT_TD1 = 16_593_00.to_d

      RATES_AND_CONSTANTS = {
        48_326_00.to_d => [LOWEST_RATE, 0.0.to_d],
        96_655_00.to_d => [0.0860, 1_305_00.to_d],
        157_139_00.to_d => [0.1220, 4_784_00.to_d],
        BigDecimal("Infinity") => [0.1405, 7_691_00.to_d]
      }.freeze
    end
  end
end
