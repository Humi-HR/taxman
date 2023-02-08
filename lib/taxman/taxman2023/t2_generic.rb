# frozen_string_literal: true

module Taxman2023
  # Calculates the annualized provincial tax
  class T2Generic
    attr_reader :a, :t4

    def initialize(a:, t4:)
      @a = a.to_d
      @t4 = t4.to_d # Basic annualized provincial tax
    end

    def self.params
      %i[a t4]
    end

    def amount
      t4 + v1 + v2 - s
    end

    def v1
      0
    end

    def v2
      0
    end

    def s
      0
    end
  end
end
