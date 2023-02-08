# frozen_string_literal: true

module Taxman2023
  # Calculates the T factor from the T1 and T2
  class T
    attr_reader :t1, :t2, :p, :l

    def initialize(t1:, t2:, p:, l:)
      @t1 = t1
      @t2 = t2
      @p = p
      @l = l
    end

    def self.params
      %i[t1 t2 p l]
    end

    def amount
      ((t1 + t2) / p) + l
    end
  end
end
