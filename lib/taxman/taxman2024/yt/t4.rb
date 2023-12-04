# frozen_string_literal: true

module Taxman2024
  module Yt
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0640.to_d
      CEA = 1_433_00.to_d
      K4P_RATE = LOWEST_RATE

      RATES_AND_CONSTANTS = {
        55_867_00.to_d => [LOWEST_RATE, 0.0.to_d],
        111_733_00.to_d => [0.0900, 1_453_00.to_d],
        173_205_00.to_d => [0.1090, 3_575_00.to_d],
        500_000_00.to_d => [0.1280, 6_866_00.to_d],
        BigDecimal("Infinity") => [0.1500, 17_866_00.to_d]
      }.freeze

      def tcp
        @tcp ||= [Bpaf.new(a: a, hd: hd).amount + @tcp_offset, 0].max
      end

      def k4p
        [K4P_RATE * a, K4P_RATE * CEA].min
      end
    end
  end
end
