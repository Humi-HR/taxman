# frozen_string_literal: true

module Taxman2023
  # This calculates the total annual taxable income from the income for the period
  class A
    attr_reader :p,
                :i,
                :f,
                :f2,
                :f5a,
                :u1,
                :hd,
                :f1

    def self.params
      %i[p i f f2 f5a u1 hd f1]
    end

    def initialize(
      p:,
      i:,
      f:,
      f2:,
      f5a:,
      u1:,
      hd:,
      f1:
    )
      @p = p
      @i = i.to_d
      @f = f.to_d
      @f2 = f2.to_d
      @f5a = f5a.to_d
      @u1 = u1.to_d
      @hd = hd.to_d
      @f1 = f1.to_d
    end

    def amount
      a = (p * (i - f - f2 - f5a - u1)) - hd - f1

      return 0 if a <= 0

      a
    end
  end
end
