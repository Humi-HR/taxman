# frozen_string_literal: true

module Taxman2024
  # This creates the output hash entries for the cpp values
  class CppCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_cpp_contribution: cpp_contribution,
                    employer_cpp_contribution: cpp_contribution,
                    employee_cpp2_contribution: cpp2_contribution,
                    employer_cpp2_contribution: cpp2_contribution)
    end

    def cpp_contribution
      (context[:c] / 100).round(2)
    end

    def cpp2_contribution
      (context[:c2] / 100).round(2)
    end
  end
end
