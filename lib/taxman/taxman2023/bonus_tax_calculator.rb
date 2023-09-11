# frozen_string_literal: true

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

      a_without_bonus = ABonus
                        .new(a: a, current_bonus_term: current_without_bonus, ytd_bonus_term: ytd_bonus_term)
                        .amount

      taxes_with_bonus = TaxCalculator.new(context: context.merge(a: a_bonus)).calculate
      taxes_without_bonus = TaxCalculator
                            .new(context: context.merge(zeroed_bonus_terms(context, a_without_bonus)))
                            .calculate

      # While not explicitly defined in T4127, the bonus taxes is the
      # difference when calculating taxes with and without bonus, though it is
      # only implied that taxes with bonuses should be a larger amount.
      # It is possible for this difference to be negative with no taxable
      # income (tax exempt) and a custom tax deduction. While not stated, bonus
      # taxes should not be negative.
      # We likely handle tax exempt wrong, and should fix it:
      # https://gethumi.atlassian.net/browse/PAY-972
      federal_tax = [(taxes_with_bonus[:t1] - taxes_without_bonus[:t1]), 0].max

      provincial_tax = if context[:province] == Taxman::QC
                         context[:qc_d1] = QcD1.amount(context)
                         context[:qc_h2] = QcH2.amount(context)
                         context[:qc_csb] = QcCsb.amount(context)
                         context[:qc_i1] = QcI1.amount(context)
                         context[:qc_y1] = QcY1Y2.amount(context.merge({ qc_b2: 0, qc_csb: 0 }))
                         context[:qc_y2] = QcY1Y2.amount(context)
                         context[:qc_a1] = QcA1.amount(context)
                         context[:qc_a1]
                       else
                         [(taxes_with_bonus[:t2] - taxes_without_bonus[:t2]), 0].max
                       end

      # Apply flat taxes for small pay
      federal_tax, provincial_tax = small_pay_amounts(
        a_bonus,
        federal_tax,
        provincial_tax,
        context[:b],
        context[:province]
      )

      total_tax = federal_tax + provincial_tax
      # Remove the calculated taxes from the result, since TaxCalculator spreads out over the
      # year and we're taking all of the taxes on the bonus this period
      {
        taxes_with_bonus: taxes_with_bonus.except(:federal_taxes, :provincial_taxes),
        taxes_without_bonus: taxes_without_bonus.except(:federal_taxes, :provincial_taxes),
        federal_tax_on_bonus: (federal_tax / 100).round(2),
        provincial_tax_on_bonus: (provincial_tax / 100).round(2),
        total_bonus_tax: (total_tax / 100).round(2),
        qc_i1: context[:qc_i1],
        qc_y1: context[:qc_y1],
        qc_y2: context[:qc_y2],
        qc_a1: context[:qc_a1]
      }
    end

    private

    # Apply flat tax for small pay
    def small_pay_amounts(a_bonus, federal_tax, provincial_tax, b, province)
      federal_tax = b * 0.1 if a_bonus <= 5_000_00
      if a_bonus <= 5_000_00 && province != Taxman::QC
        provincial_tax = b * 0.05
      elsif a_bonus <= 17_183_00 && province == Taxman::QC
        provincial_tax = b * 0.07
      end
      [federal_tax, provincial_tax]
    end

    def current_bonus_terms
      %i[b b_pensionable b_insurable]
    end

    def zeroed_bonus_terms(context, a_without_bonus)
      context
        .merge(a: a_without_bonus)
        .merge(current_bonus_terms.to_h { |term| [term, 0] })
    end
  end
end
