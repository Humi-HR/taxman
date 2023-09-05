# frozen_string_literal: true

require "yaml"
require "dentaku"

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
      context[:k2] = K2.amount(context)

      # Set factors from T3
      t3 = T3.new(**context.slice(*T3.params))
      context[:t3] = t3.amount
      context[:r] = t3.r
      context[:k] = t3.k
      context[:k1] = t3.k1
      context[:tc] = t3.tc
      context[:k4] = t3.k4
      context[:cea] = t3.cea

      context[:t1] = T1.amount(context)

      # Calculate provincial taxes for Quebec or the rest of Canada
      if context[:province] == Taxman::QC
        calculate_provincial_qc_taxes

        # Set provincial tax amount
        context[:provincial_tax] = (context[:qc_a] / 100).round(2)

        # Set zero amounts for later used T4127 calculations
        context[:t2] = 0
      else
        calculate_provincial_non_qc_taxes

        # Set provincial tax amount
        context[:provincial_tax] = ((context[:t2] / context[:p]) / 100).round(2)
      end

      # Set T
      context[:t] = T.amount(context)

      context[:federal_tax] = ((context[:t1] / context[:p]) / 100).round(2)
      context[:additional_tax] = (context[:l] / 100).round(2)
      context[:total_tax] = (context[:t] / 100).round(2)

      context
    end

    private

    def calculate_provincial_qc_taxes
      # TP-1015.3 I and prerequisite factors
      calc = Dentaku::Calculator.new
      calc.add_function(:qc_rate, :numeric, -> { QcY::RATES_AND_CONSTANTS[QcY::RATES_AND_CONSTANTS.keys.sort.find { |bracket| context[:qc_i] <= bracket }][0] }) # rubocop:disable Layout/LineLength
      calc.add_function(:qc_constant, :numeric, -> { QcY::RATES_AND_CONSTANTS[QcY::RATES_AND_CONSTANTS.keys.sort.find { |bracket| context[:qc_i] <= bracket }][1] }) # rubocop:disable Layout/LineLength

      YAML.load(File.read("factors.yml")).each do |name, formula|
        context[name.to_sym] = calc.evaluate! formula, **context
      end
    end

    def calculate_provincial_non_qc_taxes
      # Prep factors for T2 & T4
      context[:k2p] = k2p_class.amount(context)

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
    end

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
