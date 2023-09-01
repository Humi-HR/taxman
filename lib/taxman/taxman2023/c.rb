# frozen_string_literal: true

module Taxman2023
  # Calculates the CPP contribution for the period
  class C < Factor
    def self.params
      %i[pi p pm d b_pensionable dq]
    end
    attr_reader(*params)

    def amount
      [cpp_max, cpp_calculated].min
    end

    def cpp_max
      [(Cpp::MAX * pm / 12) - ((dq * (Cpp::RATE / Qpp::RATE)) + d), 0].max
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
      cpp = (i_pensionable - (Cpp::BASIC_EXEMPTION / p)) * Cpp::RATE

      [cpp, 0].max + (b_pensionable * Cpp::RATE)
    end
  end
end
