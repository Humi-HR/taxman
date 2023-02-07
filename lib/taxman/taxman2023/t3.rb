# frozen_string_literal: true

module Taxman2023
  # This is the annual basic federal tax
  class T3
    attr_reader :a, :hd, :k2, :k3

    FIRST_THRESHOLD = 53_359_00.to_d
    SECOND_THRESHOLD = 106_717_00.to_d
    THIRD_THRESHOLD = 165_430_00.to_d
    FOURTH_THRESHOLD = 235_675_00.to_d

    def initialize(a:, hd:, k2:, k3: 0)
      @a = a
      @hd = hd
      @k2 = k2
      @k3 = k3 # Other federal non-refundable tax credits
    end

    def amount
      return 0 if a <= 0

      ((r * a) - k - k1 - k2 - k3 - k4).round(2)
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

    def k
      @k ||= if a <= FIRST_THRESHOLD
               0
             elsif a <= SECOND_THRESHOLD
               2_935_00.to_d
             elsif a <= THIRD_THRESHOLD
               8_804_00.to_d
             elsif a <= FOURTH_THRESHOLD
               13_767_00.to_d
             else
               23_194_00.to_d
             end
    end
    # rubocop:enable Metrics/MethodLength

    def k1
      0.15 * Bpaf.new(a: a, hd: hd).amount
    end

    def k4
      [0.15 * cea, 0.15 * a].min
    end

    def cea
      1_368_00.to_d
    end
  end
end
