# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/ComparableClamp
module Taxman2023
  module On
    # This calculates the T2 factor for ontario
    class T2 < T2Generic
      def v1
        if t4 <= 5_315_00.to_d
          0
        elsif t4 <= 6_802_00.to_d
          0.2 * (t4 - 5_315_00.to_d)
        else
          (0.2 * (t4 - 5_315_00.to_d)) + (0.36 * (t4 - 6_802_00.to_d))
        end
      end

      def v2
        if a <= 20_000_00.to_d
          0
        elsif a <= 36_000_00.to_d
          [300_00.to_d, 0.06 * (a - 20_000_00.to_d)].min
        elsif a <= 48_000_00.to_d
          [450_00.to_d, 300 + (0.06 * (a - 36_000_00.to_d))].min
        elsif a <= 72_000_00.to_d
          [600_00, 450 + (0.25 * (a - 48_000_00.to_d))].min
        elsif a <= 200_000_00.to_d
          [750_00, 600 + (0.25 * (a - 72_000_00))].min
        else
          [900_00, 750 + (0.25 * (a - 200_000_00))].min
        end.to_d
      end

      def s
        [[t4 + v1, (2 * (s2 + 0)) - (t4 + v1)].min, 0].max.to_d
      end

      def s2
        274_00.to_d
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Style/ComparableClamp
