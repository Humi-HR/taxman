# frozen_string_literal: true

module Taxman2023
  # Maps string jurisdictions to taxman modules
  class ModuleMapper
    attr_reader :province

    MODULE_MAP = {
      "ON" => Taxman2023::On,
      "NL" => Taxman2023::Nl
    }.freeze

    def self.map(province)
      MODULE_MAP[province]
    end
  end
end
