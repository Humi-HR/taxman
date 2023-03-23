# frozen_string_literal: true

require "bigdecimal/util"
require_relative "taxman/version"
require_relative "taxman/taxman2022"
require_relative "taxman/taxman2023"

module Taxman
  class Error < StandardError; end

  class ContextMissing < StandardError; end
end
