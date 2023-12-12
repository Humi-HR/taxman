# frozen_string_literal: true

module Taxman2024
  # This creates the output hash entries for the qpp values
  class QppCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_qpp_contribution: amount,
                    employer_qpp_contribution: amount,
                    employee_qpp2_contribution: amount2,
                    employer_qpp2_contribution: amount2)
    end

    def amount
      return 0 if context[:province] != Taxman::QC

      (context[:qc_c] / 100.0).round(2)
    end

    def amount2
      return 0 if context[:province] != Taxman::QC

      (context[:qc_c2] / 100.0).round(2)
    end
  end
end
