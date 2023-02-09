# frozen_string_literal: true

module Taxman2023
  module Nu
    # Calculates the k2p factor for Nunavut
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
