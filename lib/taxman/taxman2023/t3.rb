# frozen_string_literal: true

module Taxman2023
  # This is the annual basic federal tax
  class T3
    attr_reader :a

    def initialize(a:)
      @a = a
    end

    def amount
    end

    private

    def r; end
    def k1; end
    def k2; end
    def k3; end
    def k4; end
  end
end
