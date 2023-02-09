# frozen_string_literal: true

module Taxman2023
  module Nb
    # Calculates the k2p factor for No Funswick
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
