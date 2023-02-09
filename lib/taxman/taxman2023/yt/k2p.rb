# frozen_string_literal: true

module Taxman2023
  module Yt
    # Calculates the k2p factor for the Yukon Territory
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
