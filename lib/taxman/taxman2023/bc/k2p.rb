# frozen_string_literal: true

module Taxman2023
  module Bc
    # Calculates the k2p factor for BC
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
