# frozen_string_literal: true

# Taxman for tax year 2022
module Taxman2022
  Dir["#{File.dirname(__FILE__)}/taxman2022/**/*.rb"].each { |f| require(f) }
end
