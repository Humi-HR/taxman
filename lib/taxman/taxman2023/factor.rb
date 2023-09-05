# frozen_string_literal: true

require "dentaku"

module Taxman2023
  # base class for tax factors
  class Factor
    def initialize(**params)
      self.class.params.each do |param|
        value = params[param]
        value = value.to_d unless value.is_a?(String)
        instance_variable_set("@#{param}", value)
      end
    end

    def self.amount(context)
      new(**context.slice(*params)).amount
    end

    def evaluate(expression)
      Dentaku::Calculator.new.evaluate! expression, **context
    end

    def context
      instance_variables.each_with_object({}) do |attribute, hash|
        hash[attribute.to_s[1..].to_sym] = instance_variable_get(attribute)
      end
    end
  end
end
