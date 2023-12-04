# frozen_string_literal: true

# Taxman for tax year 2024
module Taxman2024
  require_relative "taxman2024/factor"
  require_relative "taxman2024/k2_generic"
  require_relative "taxman2024/k2_p_generic"
  require_relative "taxman2024/t2_generic"
  require_relative "taxman2024/t4_generic"

  Dir["#{File.dirname(__FILE__)}/taxman2024/**/*.rb"].each do |file|
    next if Pathname.new(file).basename.to_s == "module_mapper.rb"

    require(file)
  end

  require_relative "taxman2024/module_mapper"
end
