# frozen_string_literal: true

module Taxman2023
  module On
    # Calculates the k2p factor for Ontario
    class K2p < K2PGeneric
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
