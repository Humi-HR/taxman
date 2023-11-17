# frozen_string_literal: true

module Taxman2024
  module Pe
    # Calculates the T2 factor for BC
    class T2 < T2Generic
      THRESHOLD = 12_500_00.to_d

      def v1
        return 0.to_d if t4 <= THRESHOLD

        BigDecimal("0.1") * (t4 - THRESHOLD)
      end
    end
  end
end
