# frozen_string_literal: true

RSpec.describe Taxman2023::Yt::T4 do
  let(:t4) { described_class.new(a: a, hd: 0, tcp: nil, k2p: 0, k3p: 0) }

  describe "#k4p" do
    context "when a is less than CEA" do
      let(:a) { 1_000_00 }

      it "equals 6.4% times a" do
        expect(t4.k4p).to eq 0.064 * a
      end
    end

    context "when a is greater than CEA" do
      let(:a) { 2_000_00 }

      it "equals 6.4% times CEA" do
        expect(t4.k4p).to eq 0.064 * described_class::CEA
      end
    end
  end
end
