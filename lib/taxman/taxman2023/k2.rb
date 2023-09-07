# frozen_string_literal: true

module Taxman2023
  # Calculates the K2P factor for federal income tax
  class K2 < K2PGeneric
    def rate
      T3::LOWEST_RATE
    end
  end
end
