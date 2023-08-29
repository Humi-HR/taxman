# frozen_string_literal: true

module Taxman2023
  # Calculates the T factor from the T1 and T2
  class T
    attr_reader :t1, :t2, :p, :l, :province

    def initialize(t1:, t2:, p:, l:, province:)
      @t1 = t1
      @t2 = t2
      @p = p
      @l = l
      @province = province
    end

    def self.params
      %i[t1 t2 p l province]
    end

    def amount
      if province == Taxman::QC
        (t1 / p) + l
      else
        ((t1 + t2) / p) + l
      end
    end
  end
end
