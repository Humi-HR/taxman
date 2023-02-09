# frozen_string_literal: true

module Taxman2023
  # Calculates the K2 factor for federal income tax
  class K2 < K2Generic
    def rate
      T3::LOWEST_RATE
    end
  end
end
