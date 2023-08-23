# frozen_string_literal: true

require "bigdecimal/util"
require_relative "taxman/version"
require_relative "taxman/taxman2021"
require_relative "taxman/taxman2022"
require_relative "taxman/taxman2023"

module Taxman
  class Error < StandardError; end

  class ContextMissing < StandardError; end

  class UnsupportedProvince < StandardError; end

  %w[AB BC MB NB NL NS NT NU ON PE QC SK YT].each do |province|
    const_set(province, province)
  end
end
