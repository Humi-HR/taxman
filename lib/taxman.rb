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

  AB = "AB"
  BC = "BC"
  MB = "MB"
  NB = "NB"
  NL = "NL"
  NS = "NS"
  NT = "NT"
  NU = "NU"
  ON = "ON"
  PE = "PE"
  QC = "QC"
  SK = "SK"
  YT = "YT"
end
