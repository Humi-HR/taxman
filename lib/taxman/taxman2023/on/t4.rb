# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module Taxman2023
  module On
    # Calculates the annualized provincial tax
    class T4
      attr_reader :a,
                  :b,
                  :b1,
                  :p,
                  :k2p,
                  :k3p

      FIRST_THRESHOLD = 49_231_00.to_d
      SECOND_THRESHOLD = 98_463_00.to_d
      THIRD_THRESHOLD = 150_000_00.to_d
      FOURTH_THRESHOLD = 220_000_00.to_d

      def initialize(
        a:,
        tcp:,
        k2p:,
        k3p:
      )
        @a = a.to_d # Annualized income
        @tcp = tcp&.to_d # Personal exemption from provincial TD1, or we use the basic exemption
        @k2p = k2p.to_d # Tax credit for cpp contributions
        @k3p = k3p.to_d # Other non-refundable provincial tax credits
      end

      def amount
        [((v * a) - kp - k1p - k2p - k3p - k4p).round(2), 0].max
      end

      def k1p
        0.0505 * tcp
      end

      def tcp
        @tcp ||= 11_865_00.to_d
      end

      def k4p
        0
      end

      def v
        @v ||= if a <= FIRST_THRESHOLD
                 0.0505.to_d
               elsif a <= SECOND_THRESHOLD
                 0.0915.to_d
               elsif a <= THIRD_THRESHOLD
                 0.1116.to_d
               elsif a <= FOURTH_THRESHOLD
                 0.1216.to_d
               else
                 0.1316.to_d
               end
      end

      def kp
        @kp ||= if a <= FIRST_THRESHOLD
                  0.to_d
                elsif a <= SECOND_THRESHOLD
                  2_018_00.to_d
                elsif a <= THIRD_THRESHOLD
                  3_998_00.to_d
                elsif a <= FOURTH_THRESHOLD
                  5_498_00.to_d
                else
                  7_698_00.to_d
                end
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
