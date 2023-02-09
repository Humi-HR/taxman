# frozen_string_literal: true

module Taxman2023
  module Ab
    # Calculates the k2p factor for Alberta
    class K2p < K2Generic
      def rate
        T4::LOWEST_RATE
      end
    end
  end
end
