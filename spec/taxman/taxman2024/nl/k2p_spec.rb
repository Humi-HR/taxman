# frozen_string_literal: true

RSpec.describe Taxman2024::Nl::K2p do
  let(:k2p) { described_class.new(**k2_params).amount }
  let(:b) { 0 }
  let(:b1) { 0 }
  let(:d) { 0 } # YTD CPP contribution
  let(:d1) { 0 } # YTD EI contribution
  let(:k2_params) do
    {
      pi: i,
      pi_periodic: i,
      b_pensionable: b,
      b1_pensionable: b1,
      ie: i,
      ie_periodic: i,
      b_insurable: b,
      b1_insurable: b1,
      p: p,
      d: d,
      d1: d1
    }
  end

  context "with $84k salary monthly" do
    let(:i) { 7_000_00 }
    let(:p) { 12 }

    # https://docs.google.com/spreadsheets/d/1Kh9TLeYrnnqyr7BkKyuFyAWDOvkUvAlBzFAKLBB3Vbe_within(0.01).of/edit#gid=562910102
    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 358_95.33.to_d
    end
  end
end
