# frozen_string_literal: true

# Taxman for tax year 2023
module Taxman2023
  require_relative "taxman2023/k2_generic"
  require_relative "taxman2023/t2_generic"
  require_relative "taxman2023/t4_generic"

  Dir["#{File.dirname(__FILE__)}/taxman2023/**/*.rb"].each do |file|
    next if Pathname.new(file).basename.to_s == "module_mapper.rb"

    require(file)
  end

  require_relative "taxman2023/module_mapper"
end
