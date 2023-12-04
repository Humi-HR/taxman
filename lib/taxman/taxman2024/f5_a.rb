# frozen_string_literal: true

module Taxman2024
  # Calculates the F5A factor
  class F5A < Factor
    def self.params
      %i[pi b_pensionable f5 f5q province]
    end
    attr_reader(*params)

    def amount
      return 0 if pi <= 0

      f = if province == Taxman::QC
            f5q
          else
            f5
          end

      return f if b_pensionable <= 0

      f * ((pi - b_pensionable) / pi)
    end
  end
end
