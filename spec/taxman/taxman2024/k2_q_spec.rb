# frozen_string_literal: true

RSpec.describe Taxman2024::K2Q do
  let(:k2q) { described_class.amount(**k2q_params) }
  let(:k2q_params) do
    {
      p: p,
      pm: pm,
      d1: d1,
      d: d,
      b_pensionable: b_pensionable,
      b1_pensionable: b1_pensionable,
      qc_a5: qc_a5,
      qc_a6: qc_a6,
      pi_periodic: pi_periodic,
      ie_periodic: ie_periodic,
      b_insurable: b_insurable,
      b1_insurable: b1_insurable
    }
  end
  let(:p) { 12 }
  let(:pm) { 12 }
  let(:d1) { 0 }
  let(:d) { 0 }
  let(:b_pensionable) { 0 }
  let(:b1_pensionable) { 0 }
  let(:qc_a5) { 0 }
  let(:qc_a6) { 0 }
  let(:pi_periodic) { 5_000_00.to_d }
  let(:ie_periodic) { 5_000_00.to_d }
  let(:b_insurable) { 0 }
  let(:b1_insurable) { 0 }

  it "returns correct value" do
    expect(k2q).to be_within(1).of 620_91.00.to_d
  end

  context "with bonus terms" do
    let(:b_pensionable) { 20_000_00.to_d }
    let(:b_insurable) { 20_000_00.to_d }

    it "return correct k2q value" do
      expect(k2q).to be_within(1).of 710_61.60.to_d
    end
  end
end
