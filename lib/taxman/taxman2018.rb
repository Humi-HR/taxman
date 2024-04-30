# frozen_string_literal: true

# Taxman for tax year 2018
module Taxman2018
  Dir["#{File.dirname(__FILE__)}/taxman2018/**/*.rb"].each { |f| require(f) }
end
