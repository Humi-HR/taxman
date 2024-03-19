# frozen_string_literal: true

# Taxman for tax year 2020
module Taxman2020
  Dir["#{File.dirname(__FILE__)}/taxman2020/**/*.rb"].each { |f| require(f) }
end
