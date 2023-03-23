# frozen_string_literal: true

module Taxman2023
  # Calculates the F5A factor
  class F5A
    attr_reader :pi, :b, :f5

    def initialize(pi:, b:, f5:)
      @pi = pi.to_d
      @b = b.to_d
      @f5 = f5.to_d
    end

    def self.params
      %i[pi b f5]
    end

    def amount
      return 0 if pi <= 0
      return f5 if b <= 0

      f5 * ((pi - b) / pi)
    end
  end
end
