# frozen_string_literal: true

# Taxman for tax year 2021
module Taxman2021
  Dir["#{File.dirname(__FILE__)}/taxman2021/**/*.rb"].each { |f| require(f) }
end
