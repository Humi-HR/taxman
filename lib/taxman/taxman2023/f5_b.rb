# frozen_string_literal: true

module Taxman2023
  # Calculates the F5B factor
  class F5B
    attr_reader :pi, :b, :f5, :f5q, :province

    # Pensionable income here _includes_ the bonus!
    def initialize(f5:, b:, pi:, f5q:, province:)
      @f5 = f5.to_d
      @b = b.to_d
      @pi = pi.to_d
      @f5q = f5q.to_d
      @province = province
    end

    def self.params
      %i[f5 b pi f5q province]
    end

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
