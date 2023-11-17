# frozen_string_literal: true

module Taxman2023
  # Calculates the basic annualized provincial tax
  class T4Generic < Factor
    def initialize(
      a:,
      hd:,
      k2p:,
      k3p:,
      tcp: nil,
      tcp_offset: 0
    )
      super
      @tcp = tcp&.to_d # Personal exemption from provincial TD1, or we use the basic exemption
    end

    def self.params
      %i[a hd k2p k3p tcp tcp_offset]
    end
    attr_reader(*params)

    def amount
      [(v * a) - kp - k1p - k2p - k3p - k4p, 0.to_d].max
    end

    def k4p
      0.to_d
    end

    def k1p
      self.class::LOWEST_RATE * tcp
    end

    def tcp
      @tcp ||= [self.class::DEFAULT_TD1 + @tcp_offset, 0].max
    end

    def v
      rate, = self.class::RATES_AND_CONSTANTS[bracket]

      rate
    end

    def kp
      _, constant = self.class::RATES_AND_CONSTANTS[bracket]

      constant
    end

    private

    def bracket
      @bracket ||= self.class::RATES_AND_CONSTANTS.keys.sort.find { |bracket| a <= bracket }
    end
  end
end
