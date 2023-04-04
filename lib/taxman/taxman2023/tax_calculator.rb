# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
module Taxman2023
  # Calculate the federal and provincial taxes
  # Requires A, F5A, F5B and C to have already been set in context
  class TaxCalculator
    attr_reader :context

    REQUIRED_CONTEXT = %i[
      a
      b
      b1
      c
      p
      i
      f
      f1
      f2
      f5a
      f3
      f4
      f5b
      f5b_ytd
      u1
      hd
      k3
      k3p
      province
      l
      pi
      ie
      b_pensionable
      b_insurable
      b1_pensionable
      b1_insurable
    ].freeze

    def initialize(context:)
      @context = context
    end

    def calculate
      check_required_context

      # Prep factors for T3
      context[:k2] = K2.new(**context.slice(*K2.params)).amount

      # Set factors from T3
      t3 = T3.new(**context.slice(*T3.params))
      context[:t3] = t3.amount
      context[:r] = t3.r
      context[:k] = t3.k
      context[:k1] = t3.k1
      context[:tc] = t3.tc
      context[:k4] = t3.k4
      context[:cea] = t3.cea

      context[:t1] = context[:t3] # Since we don't support the LCF

      # Prep factors for T2 & T4
      context[:k2p] = k2p_class.new(**context.slice(*K2.params)).amount

      # Set factors from T4
      t4 = t4_class.new(**context.slice(*t4_class.params))
      context[:t4] = t4.amount
      context[:k4p] = t4.k4p
      context[:k1p] = t4.k1p
      context[:tcp] = t4.tcp
      context[:v] = t4.v
      context[:kp] = t4.kp

      # Set factors from T2
      t2 = t2_class.new(**context.slice(*t2_class.params))
      context[:t2] = t2.amount
      context[:v1] = t2.v1
      context[:v2] = t2.v2
      context[:s] = t2.s

      # Set T
      context[:t] = T.new(**context.slice(*T.params)).amount

      context[:federal_tax] = ((context[:t1] / context[:p]) / 100).round(2)
      context[:provincial_tax] = ((context[:t2] / context[:p]) / 100).round(2)
      context[:additional_tax] = (context[:l] / 100).round(2)
      context[:total_tax] = (context[:t] / 100).round(2)

      context
    end

    private

    def check_required_context
      REQUIRED_CONTEXT.each do |param|
        raise Taxman::ContextMissing, "`#{param}` is missing, can't run #{self.class}" unless context.include? param
      end
    end

    def k2p_class
      province_module::K2p
    end

    def t4_class
      province_module::T4
    end

    def t2_class
      province_module::T2
    end

    def province_module
      @province_module ||= ModuleMapper.map(context[:province])
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
