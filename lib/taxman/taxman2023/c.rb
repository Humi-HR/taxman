# frozen_string_literal: true

module Taxman2023
  # Calculates the CPP contribution for the period
  class C
    CPP_MAX = 3_754_45.to_d
    attr_reader :pi, :p, :pm, :d

    def initialize(pi:, p:, pm:, d:)
      @pi = pi.to_d
      @p = p.to_d
      @pm = pm.to_d
      @d = d.to_d
    end

    def self.params
      %i[pi p pm d]
    end

    def amount
      [cpp_max, cpp_calculated].min
    end

    def cpp_max
      [(CPP_MAX * pm / 12) - d, 0].max
    end

    def cpp_calculated
      cpp = (pi - (3_500_00.to_d / p)) * 0.0595

      [cpp, 0].max
    end
  end
end
