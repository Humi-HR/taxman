# frozen_string_literal: true

module Taxman2024
  # second additional CPP contributions
  class C2 < Factor
    def self.params
      %i[pm d2 pi_ytd pi w]
    end
    attr_reader(*params)

    def amount
      c2 = [
        (Cpp::MAX_ADDITIONAL * (pm / 12)) - d2,
        (pi_ytd + pi - w) * Cpp::ADDITIONAL_RATE
      ].min

      [c2, 0].max
    end
  end
end
