# frozen_string_literal: true

module Taxman2023
  # Income tax for the year
  class QcY < Factor
    RATES_AND_CONSTANTS = {
      49_275_00 => [0.14, 0],
      98_540_00 => [0.19, 2_463_00],
      119_910_00 => [0.24, 7_390_00],
      BigDecimal("Infinity") => [0.2575, 9_489_00]
    }.to_h { |k, v| [k.to_d, v.map(&:to_d)] }.freeze
  end
end
