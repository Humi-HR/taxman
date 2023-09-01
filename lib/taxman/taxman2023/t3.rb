# frozen_string_literal: true

module Taxman2023
  # This is the annual basic federal tax
  class T3 < Factor
    LOWEST_RATE = 0.150.to_d

    RATES_AND_CONSTANTS = {
      53_359_00.to_d => [LOWEST_RATE, 0.0.to_d],
      106_717_00.to_d => [0.205.to_d, 2_935_00.to_d],
      165_430_00.to_d => [0.260.to_d, 8_804_00.to_d],
      235_675_00.to_d => [0.290.to_d, 13_767_00.to_d],
      BigDecimal("Infinity") => [0.330.to_d, 23_194_00.to_d]
    }.freeze

    def initialize(a:, hd:, k2:, tc: nil, k3: 0, tc_offset: 0)
      super
      @tc = tc&.to_d
      @tc_offset = tc_offset&.to_d
    end

    def self.params
      %i[a hd k2 k3 tc tc_offset]
    end
    attr_reader(*params)

    def amount
      return 0 if a <= 0

      [(r * a) - k - k1 - k2 - k3 - k4, 0].max
    end

    def r
      rate, = RATES_AND_CONSTANTS[bracket]

      rate
    end

    def k
      _, constant = RATES_AND_CONSTANTS[bracket]

      constant
    end

    def k1
      LOWEST_RATE * tc
    end

    def tc
      @tc ||= [Bpaf.new(a: a, hd: hd).amount + @tc_offset, 0].max
    end

    def k4
      [LOWEST_RATE * cea, LOWEST_RATE * a].min
    end

    def cea
      1_368_00.to_d
    end

    private

    def bracket
      @bracket ||= RATES_AND_CONSTANTS.keys.sort.find { |bracket| a <= bracket }
    end
  end
end
