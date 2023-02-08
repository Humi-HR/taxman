# frozen_string_literal: true

module Taxman2023
  # Calculates the basic annualized provincial tax
  class T4Generic
    attr_reader :a,
                :k2p,
                :k3p

    def initialize(
      a:,
      k2p:,
      k3p:,
      tcp: nil
    )
      @a = a.to_d # Annualized income
      @tcp = tcp&.to_d # Personal exemption from provincial TD1, or we use the basic exemption
      @k2p = k2p.to_d # Tax credit for cpp contributions
      @k3p = k3p.to_d # Other non-refundable provincial tax credits
    end

    def self.params
      %i[a k2p k3p tcp]
    end

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
      @tcp ||= self.class::DEFAULT_TD1
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
