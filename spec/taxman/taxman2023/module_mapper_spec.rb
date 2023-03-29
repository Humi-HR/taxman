# frozen_string_literal: true

RSpec.describe Taxman2023::ModuleMapper do
  let(:mapper) { described_class.map(province) }

  context "when given ON" do
    let(:province) { "ON" }

    it "maps to the correct module" do
      expect(mapper).to eq Taxman2023::On
    end
  end

  context "when given NL" do
    let(:province) { "NL" }

    it "maps to the correct module" do
      expect(mapper).to eq Taxman2023::Nl
    end
  end

  context "when given QC" do
    let(:province) { "QC" }

    it "maps to the correct module" do
      expect { mapper }.to raise_error Taxman::UnsupportedProvince
    end
  end
end
