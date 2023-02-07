# frozen_string_literal: true

module Taxman2023
  module On
    # Calculates the k2p factor for ontario
    class K2p
      attr_reader :i, # Income in the period
                  :b, # Bonus in the period
                  :b1, # Bonus YTD
                  :p # Number of periods

      def initialize(
        i:,
        b:,
        b1:,
        p:
      )
        @i = i.to_d
        @b = b.to_d
        @b1 = b1.to_d
        @p = p
      end

      def amount
        Taxman2023::K2Generic.new(
          i: i,
          b: b,
          b1: b1,
          p: p,
          rate: 0.0505
        ).amount
      end
    end
  end
end
