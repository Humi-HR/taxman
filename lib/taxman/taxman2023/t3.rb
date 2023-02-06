# frozen_string_literal: true

module Taxman2023
  # This is the annual basic federal tax
  class T3
    attr_reader :a, :hd

    FIRST_THRESHOLD = 53_359_00.to_d
    SECOND_THRESHOLD = 106_717_00.to_d
    THIRD_THRESHOLD = 165_430_00.to_d
    FOURTH_THRESHOLD = 235_675_00.to_d

    def initialize(a:, hd:)
      @a = a
      @hd = hd
    end

    def amount
      return 0 if a <= 0

      (r * a) - k - k1 - k2 - k3 - k4
    end

    # rubocop:disable Metrics/MethodLength
    def r
      @r ||= if a <= FIRST_THRESHOLD
               0.150
             elsif a <= SECOND_THRESHOLD
               0.205
             elsif a <= THIRD_THRESHOLD
               0.260
             elsif a <= FOURTH_THRESHOLD
               0.290
             else
               0.330
             end
    end
    # rubocop:enable Metrics/MethodLength

    def k
      0
    end

    def k1
      0.15 * Bpaf.new(a: a, hd: hd).amount
    end

    def k2
      0
    end

    def k3
      0
    end

    def k4
      0
    end
  end
end
