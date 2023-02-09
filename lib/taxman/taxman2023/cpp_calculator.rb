# frozen_string_literal: true

module Taxman2023
  # This creates the output hash entries for the cpp values
  class CppCalculator
    attr_reader :context

    def initialize(context:)
      @context = context
    end

    def calculate
      context.merge(employee_cpp_contribution: (context[:c] / 100).round(2),
                    employer_cpp_contribution: (context[:c] / 100).round(2))
    end
  end
end
