# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
module Taxman2023
  # Calculates the federal and provincial bonus taxes
  class BonusTax
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      a = A.new(**context.slice(*A.params))

      current_bonus = CurrentBonusTerm.new(**context.slice(*CurrentBonusTerm.params))
      current_without_bonus = CurrentBonusTerm.new(b: 0, f3: 0, f5b: 0)
      ytd_bonus_term = YtdBonusTerm.new(**context.slice(*YtdBonusTerm.params))

      a_bonus = ABonus
                .new(a: a, current_bonus_term: current_bonus, ytd_bonus_term: ytd_bonus_term)
                .amount

      return small_pay_amount(context[:b]) if a_bonus <= 5_000_00

      a_without_bonus = ABonus
                        .new(a: a, current_bonus_term: current_without_bonus, ytd_bonus_term: ytd_bonus_term)
                        .amount

      taxes_with_bonus = TaxCalculator.new(context: context.merge(a: a_bonus)).calculate
      taxes_without_bonus = TaxCalculator.new(context: context.merge(a: a_without_bonus)).calculate

      # Remove the calculated taxes from the result, since TaxCalculator spreads out over the
      # year and we're taking all of the taxes on the bonus this period
      {
        taxes_with_bonus: taxes_with_bonus.except(:federal_taxes, :provincial_taxes),
        taxes_without_bonus: taxes_without_bonus.except(:federal_taxes, :provincial_taxes),
        federal_tax_on_bonus: taxes_with_bonus[:t1] - taxes_without_bonus[:t1],
        provincial_tax_on_bonus: taxes_with_bonus[:t2] - taxes_without_bonus[:t2]
      }
    end

    def small_pay_amount(b)
      {
        federal_tax_on_bonus: b * 0.1,
        provincial_tax_on_bonus: b * 0.05,
        taxes_with_bonus: {},
        taxes_without_bonus: {}
      }
    end
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
