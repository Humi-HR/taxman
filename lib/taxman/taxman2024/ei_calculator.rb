# frozen_string_literal: true

module Taxman2024
  # This adds the output hash entries for ei to the context
  class EiCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_ei_contribution: (context[:ei] / 100).round(2),
                    employer_ei_contribution: (employer_portion / 100).round(2))
    end

    private

    def employer_portion
      (context[:employer_ei_multiple] || 1.4) * context[:ei]
    end
  end
end
