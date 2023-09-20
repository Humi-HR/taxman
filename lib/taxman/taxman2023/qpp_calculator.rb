# frozen_string_literal: true

module Taxman2023
  # This creates the output hash entries for the qpp values
  class QppCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_qpp_contribution: amount,
                    employer_qpp_contribution: amount)
    end

    def amount
      context[:province] == Taxman::QC ? (context[:qc_c] / 100.0).round(2) : 0
    end
  end
end
