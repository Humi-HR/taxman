# frozen_string_literal: true

module Taxman2024
  # This creates the output hash entries for the qipp values
  class QpipCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_qpip_contribution: amount(:qc_ap),
                    employer_qpip_contribution: amount(:qc_ap1))
    end

    def amount(key)
      context[:province] == Taxman::QC ? (context[key] / 100.0).round(2) : 0
    end
  end
end
