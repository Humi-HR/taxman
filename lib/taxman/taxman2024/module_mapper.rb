# frozen_string_literal: true

module Taxman2024
  # Maps string jurisdictions to taxman modules
  class ModuleMapper
    attr_reader :province

    MODULE_MAP = {
      "AB" => Taxman2024::Ab,
      "BC" => Taxman2024::Bc,
      "MB" => Taxman2024::Mb,
      "NB" => Taxman2024::Nb,
      "NL" => Taxman2024::Nl,
      "NS" => Taxman2024::Ns,
      "NT" => Taxman2024::Nt,
      "NU" => Taxman2024::Nu,
      "ON" => Taxman2024::On,
      "PE" => Taxman2024::Pe,
      "SK" => Taxman2024::Sk,
      "YT" => Taxman2024::Yt
    }.freeze

    def self.map(province)
      MODULE_MAP[province].tap do |p|
        raise Taxman::UnsupportedProvince, "Province `#{province}` is not supported" unless p
      end
    end
  end
end
