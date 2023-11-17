# frozen_string_literal: true

module Taxman2024
  # The main entry point to the tax calculator
  class Calculate
    attr_reader :period_input, :year_input, :personal_tax_input, :pension_input,
                :qpip_input, :ei_input, :context

    def initialize(
      period_input:,
      year_input:,
      personal_tax_input:,
      ei_input:,
      pension_input:,
      qpip_input: Taxman2024::QpipInput.new
    )
      @period_input = period_input
      @year_input = year_input
      @personal_tax_input = personal_tax_input
      @pension_input = pension_input
      @qpip_input = qpip_input
      @ei_input = ei_input
    end

    def call
      raise_unless_enabled

      @context = {}
      [period_input, year_input, personal_tax_input, pension_input, qpip_input, ei_input].each do |input|
        context.merge!(input.translate)
      end

      context[:c] = context[:province] == Taxman::QC ? 0.to_d : C.amount(context)
      context[:qc_c] = context[:province] == Taxman::QC ? QcC.amount(context) : 0.to_d
      context[:qc_ap] = QcAp.amount(context)
      context[:qc_ap1] = QcAp1.amount(context)
      context[:ei] = Ei.amount(context)
      context[:f5] = F5.amount(context)
      context[:f5q] = F5Q.amount(context)
      context[:f5a] = F5A.amount(context)
      context[:f5b] = F5B.amount(context)

      context[:a] = A.amount(context)

      # The non bonus tax calculation should not have the bonus, but we need it for the bonus tax calculation
      # Could definitely need a refactor
      context
        .merge!(TaxCalculator.new(context: context_without_bonus(context))
        .calculate
        .except(*bonus_symbols))
      context.merge!(BonusTaxCalculator.new(context: context).calculate) if context[:b] >= 0
      context.merge!(CppCalculator.new(context: context).calculate)
      context.merge!(QppCalculator.new(context: context).calculate)
      context.merge!(QpipCalculator.new(context: context).calculate)
      context.merge!(EiCalculator.new(context: context).calculate)

      context
    end

    def bonus_symbols
      %i[b b1 b_insurable b1_insurable b_pensionable b1_pensionable]
    end

    def context_without_bonus(context)
      context.merge(bonus_symbols.to_h { |sym| [sym, 0] })
    end

    def raise_unless_enabled
      raise "2024 not enabled" unless self.class.enabled?
    end

    def self.enable
      @enabled = true
    end

    def self.enabled?
      !!@enabled
    end
  end
end
