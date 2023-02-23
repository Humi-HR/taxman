# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
module Taxman2023
  # The main entry point to the tax calculator
  class Calculate
    attr_reader :period_input, :year_input, :td1_input, :cpp_input, :ei_input, :context

    def initialize(
      period_input:,
      year_input:,
      td1_input:,
      cpp_input:,
      ei_input:
    )
      @period_input = period_input
      @year_input = year_input
      @td1_input = td1_input
      @cpp_input = cpp_input
      @ei_input = ei_input
    end

    def call
      @context = {}
      [period_input, year_input, td1_input, cpp_input, ei_input].each do |input|
        context.merge!(input.translate)
      end

      context[:c] = C.new(**context.slice(*C.params)).amount
      context[:ei] = Ei.new(**context.slice(*Ei.params)).amount
      context[:f5] = F5.new(**context.slice(*F5.params)).amount
      context[:f5a] = F5A.new(**context.slice(*F5A.params)).amount
      context[:f5b] = F5B.new(**context.slice(*F5B.params)).amount

      context[:a] = A.new(**context.slice(*A.params)).amount

      # The non bonus tax calculation should not have the bonus, but we need it for the bonus tax calculation
      # Could definitely need a refactor
      context.merge!(TaxCalculator.new(context: context.merge(b: 0, b1: 0)).calculate.except(:b, :b1))
      context.merge!(BonusTaxCalculator.new(context: context).calculate) if context[:b] >= 0
      context.merge!(CppCalculator.new(context: context).calculate)
      context.merge!(EiCalculator.new(context: context).calculate)

      context
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength
