# frozen_string_literal: true

module Taxman2023
  # Calculates the F5B factor
  class F5B < Factor
    # Pensionable income here _includes_ the bonus!
    def self.params
      %i[f5 b pi f5q province]
    end
    attr_reader(*params)

    def amount
      return 0.to_d if pi <= 0

      f = if province == Taxman::QC
            f5q
          else
            f5
          end

      f * b / pi
    end
  end
end
