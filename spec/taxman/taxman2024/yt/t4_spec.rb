# frozen_string_literal: true

RSpec.describe Taxman2024::Yt::T4 do
  let(:t4) { described_class.new(a: a, hd: 0, tcp: nil, k2p: 0, k3p: 0) }

  describe "#k4p" do
    context "when a is less than CEA" do
      let(:a) { 1_000_00 }

      it "equals 4.7% times a" do
        expect(t4.k4p).to eq 0.047 * a
      end
    end

    context "when a is greater than CEA" do
      let(:a) { 2_000_00 }

      it "equals 4.7% times CEA" do
        expect(t4.k4p).to eq 0.047 * described_class::CEA
      end
    end
  end
end
