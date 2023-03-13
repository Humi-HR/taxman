# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
module Taxman2023
  # Calculates the federal and provincial bonus taxes
  class BonusTaxCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      # The calculation of A for bonus calculations needs to use the last non
      # zero amount of I, should I for the payroll be zero. See PAY-425 for
      # details
      a = if context[:i].zero?
            A.new(**context.merge(i: context[:previous_i]).slice(*A.params))
          else
            A.new(**context.slice(*A.params))
          end

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
      taxes_without_bonus = TaxCalculator.new(context: context.merge(a: a_without_bonus, b: 0)).calculate

      federal_tax = (taxes_with_bonus[:t1] - taxes_without_bonus[:t1])
      provincial_tax = (taxes_with_bonus[:t2] - taxes_without_bonus[:t2])
      total_tax = federal_tax + provincial_tax
      # Remove the calculated taxes from the result, since TaxCalculator spreads out over the
      # year and we're taking all of the taxes on the bonus this period
      {
        taxes_with_bonus: taxes_with_bonus.except(:federal_taxes, :provincial_taxes),
        taxes_without_bonus: taxes_without_bonus.except(:federal_taxes, :provincial_taxes),
        federal_tax_on_bonus: (federal_tax / 100).round(2),
        provincial_tax_on_bonus: (provincial_tax / 100).round(2),
        total_bonus_tax: (total_tax / 100).round(2)
      }
    end

    def small_pay_amount(b)
      federal_tax = (b * 0.1)
      provincial_tax = (b * 0.05)
      total_tax = federal_tax + provincial_tax

      {
        federal_tax_on_bonus: (federal_tax / 100).round(2),
        provincial_tax_on_bonus: (provincial_tax / 100).round(2),
        total_bonus_tax: (total_tax / 100).round(2),
        taxes_with_bonus: {},
        taxes_without_bonus: {}
      }
    end
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
