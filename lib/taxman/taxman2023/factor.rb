# frozen_string_literal: true

module Taxman2023
  # base class for tax factors
  class Factor
    def initialize(**params)
      self.class.params.each do |param|
        value = params[param]
        value = value.to_d unless value.is_a?(String) || [true, false].include?(value)
        instance_variable_set("@#{param}", value)
      end
    end

    def self.amount(context)
      parameters = params.each_with_object({}) do |param, values|
        values[param] = context.fetch(param)
      end
      new(**parameters).amount
    end
  end
end
