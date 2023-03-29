# frozen_string_literal: true

module Taxman2023
  # Maps string jurisdictions to taxman modules
  class ModuleMapper
    attr_reader :province

    MODULE_MAP = {
      "AB" => Taxman2023::Ab,
      "BC" => Taxman2023::Bc,
      "MB" => Taxman2023::Mb,
      "NB" => Taxman2023::Nb,
      "NL" => Taxman2023::Nl,
      "NS" => Taxman2023::Ns,
      "NT" => Taxman2023::Nt,
      "NU" => Taxman2023::Nu,
      "ON" => Taxman2023::On,
      "PE" => Taxman2023::Pe,
      "SK" => Taxman2023::Sk,
      "YT" => Taxman2023::Yt
    }.freeze

    def self.map(province)
      MODULE_MAP[province].tap do |p|
        raise Taxman::UnsupportedProvince, "Province `#{province}` is not supported" unless p
      end
    end
  end
end
