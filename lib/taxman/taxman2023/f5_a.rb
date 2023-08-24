# frozen_string_literal: true

module Taxman2023
  # Calculates the F5A factor
  class F5A
    attr_reader :pi, :b, :f5, :f5q, :province

    def initialize(pi:, b:, f5:, f5q:, province:)
      @pi = pi.to_d
      @b = b.to_d
      @f5 = f5.to_d
      @f5q = f5q.to_d
      @province = province
    end

    def self.params
      %i[pi b f5 f5q province]
    end

    def amount
      return 0 if pi <= 0

      f = if province == Taxman::QC
            f5q
          else
            f5
          end

      return f if b <= 0

      f * ((pi - b) / pi)
    end
  end
end
