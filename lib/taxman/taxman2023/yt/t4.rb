# frozen_string_literal: true

module Taxman2023
  module Yt
    # Calculates the annualized provincial tax
    class T4 < T4Generic
      LOWEST_RATE = 0.0640.to_d
      CEA = 1_368_00.to_d
      K4P_RATE = BigDecimal("0.064")

      RATES_AND_CONSTANTS = {
        53_359_00.to_d => [LOWEST_RATE, 0.0.to_d],
        106_717_00.to_d => [0.0900, 1_387_00.to_d],
        165_430_00.to_d => [0.1090, 3_415_00.to_d],
        500_000_00.to_d => [0.1280, 6_558_00.to_d],
        BigDecimal("Infinity") => [0.1500, 17_558_00.to_d]
      }.freeze

      def tcp
        @tcp ||= Bpaf.new(a: a, hd: hd).amount + @tcp_offset
      end

      def k4p
        [K4P_RATE * a, K4P_RATE * CEA].min
      end
    end
  end
end
