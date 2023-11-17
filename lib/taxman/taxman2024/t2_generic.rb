# frozen_string_literal: true

module Taxman2024
  # Calculates the annualized provincial tax
  class T2Generic < Factor
    def self.params
      %i[a t4]
    end
    attr_reader(*params)

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
