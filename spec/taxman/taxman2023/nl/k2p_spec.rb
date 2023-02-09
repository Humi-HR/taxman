# frozen_string_literal: true

RSpec.describe Taxman2023::Nl::K2p do
  let(:k2p) { described_class.new(i: i, b: b, b1: b1, p: p).amount }
  let(:b) { 0 }
  let(:b1) { 0 }

  context "with $84k salary monthly" do
    let(:i) { 7_000_00 }
    let(:p) { 12 }

    # https://docs.google.com/spreadsheets/d/1Kh9TLeYrnnqyr7BkKyuFyAWDOvkUvAlBzFAKLBB3Vbe_within(0.01).of/edit#gid=562910102
    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 358_95.33.to_d
    end
  end
end
