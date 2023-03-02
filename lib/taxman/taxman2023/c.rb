# frozen_string_literal: true

module Taxman2023
  # Calculates the CPP contribution for the period
  class C
    CPP_MAX = 3_754_45.to_d
    attr_reader :pi, :p, :pm, :d, :b_pensionable

    def initialize(pi:, p:, pm:, d:, b_pensionable:)
      @pi = pi.to_d
      @p = p.to_d
      @pm = pm.to_d
      @d = d.to_d
      @b_pensionable = b_pensionable.to_d
    end

    def self.params
      %i[pi p pm d b_pensionable]
    end

    def amount
      [cpp_max, cpp_calculated].min
    end

    def cpp_max
      [(CPP_MAX * pm / 12) - d, 0].max
    end

    # Calculates the CPP for an employee.
    #
    # The formula deviates slightly from the T4127#117 as pensionable bonus is
    # not described in that document. Our formula uses the pensionable part of
    # PI that is not pensionable bonus income, and calculates the CPP
    # separately on the pensionable bonus income. This matches PDOC in the
    # tested scenarios.
    def cpp_calculated
      i_pensionable = pi - b_pensionable
      cpp = (i_pensionable - (3_500_00.to_d / p)) * 0.0595

      [cpp, 0].max + (b_pensionable * 0.0595)
    end
  end
end
