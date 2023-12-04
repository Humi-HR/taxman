# frozen_string_literal: true

module Taxman2024
  module Mb
    # Calculates the k2p factor for Manitoba
    class K2p < K2PGeneric
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
