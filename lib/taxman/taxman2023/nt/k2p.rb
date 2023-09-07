# frozen_string_literal: true

module Taxman2023
  module Nt
    # Calculates the k2p factor for the NWT
    class K2p < K2PGeneric
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
