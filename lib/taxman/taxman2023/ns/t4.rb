# frozen_string_literal: true

module Taxman2023
  module Ns
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0879.to_d

      RATES_AND_CONSTANTS = {
        29_590_00.to_d => [LOWEST_RATE, 0.0.to_d],
        59_180_00.to_d => [0.1495, 1_823_00.to_d],
        93_000_00.to_d => [0.1667, 2_841_00.to_d],
        150_000_00.to_d => [0.1750, 3_613_00.to_d],
        BigDecimal("Infinity") => [0.2100, 8_863_00.to_d]
      }.freeze

      def tcp
        @tcp ||= [Bpans.new(a: a).amount + @tcp_offset, 0].max
      end
    end
  end
end
