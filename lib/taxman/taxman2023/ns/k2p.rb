# frozen_string_literal: true

module Taxman2023
  module Ns
    # Calculates the k2p factor for Nova Scotia
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
