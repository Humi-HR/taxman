# frozen_string_literal: true

module Taxman2023
  # Calculates the F5B factor
  class F5B
    attr_reader :f5, :b, :pi

    # Pensionable income here _includes_ the bonus!
    def initialize(f5:, b:, pi:)
      @f5 = f5.to_d
      @b = b.to_d
      @pi = pi.to_d
    end

    def self.params
      %i[f5 b pi]
    end

    def amount
      return 0.to_d if pi <= 0

      f5 * b / pi
    end
  end
end
