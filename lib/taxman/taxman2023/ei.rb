# frozen_string_literal: true

module Taxman2023
  # Calculates the employee's ei contributions for the period
  class Ei
    EI_MAX = 1_002_45.to_d
    attr_reader :ie, :d1

    def initialize(ie:, d1:)
      @ie = ie.to_d
      @d1 = d1.to_d
    end

    def amount
      [ei_max, ei_calculated].min
    end

    def ei_max
      [EI_MAX - d1, 0].max
    end

    def ei_calculated
      ie * 0.0163
    end
  end
end
