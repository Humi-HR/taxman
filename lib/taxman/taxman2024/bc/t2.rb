# frozen_string_literal: true

module Taxman2024
  module Bc
    # Calculates the T2 factor for BC
    class T2 < T2Generic
      S2 = 547_00.to_d

      LOWER_THRESHOLD = 24_338_00
      UPPER_THRESHOLD = 39_703_00

      def s
        return [t4, S2].min if a <= LOWER_THRESHOLD
        return 0.to_d if a > UPPER_THRESHOLD

        [t4, s_factor].min
      end

      private

      def s_factor
        S2 - ((a - LOWER_THRESHOLD) * BigDecimal("0.0356"))
      end
    end
  end
end
