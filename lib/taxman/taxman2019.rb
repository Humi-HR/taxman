# frozen_string_literal: true

# Taxman for tax year 2019
module Taxman2019
  Dir["#{File.dirname(__FILE__)}/taxman2019/**/*.rb"].each { |f| require(f) }
end
