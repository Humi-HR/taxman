# frozen_string_literal: true

module Taxman2023
  # base class for tax factors
  class Factor
    def initialize(**params)
      self.class.params.each do |param|
        instance_variable_set("@#{param}", params[param].to_d)
      end
    end

    def self.amount(context)
      new(**context.slice(*params)).amount
    end
  end
end
