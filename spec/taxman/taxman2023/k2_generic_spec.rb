# frozen_string_literal: true

RSpec.describe Taxman2023::K2Generic do
  let(:k2p_obj) { described_class.new(**k2_params) }
  let(:k2p) { k2p_obj.amount }
  let(:b1) { 0 }

  let(:k2_params) do
    {
      pi: i + b,
      pi_periodic: i,
      b_pensionable: b,
      b1_pensionable: b1,
      ie: i + b,
      ie_periodic: i,
      b_insurable: b,
      b1_insurable: b1,
      p: p
    }
  end

  before { allow(k2p_obj).to receive(:rate).and_return(0.0505) }

  context "with $54k salary monthly, $1k bonus" do
    let(:i) { 4_500_00 }
    let(:p) { 12 }
    let(:b) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 174_01.04.to_d
    end
  end

  context "with $54k salary monthly, $1k bonus, $1k ytd bonus" do
    let(:i) { 4_500_00 }
    let(:p) { 12 }
    let(:b) { 1_000_00 }
    let(:b1) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 177_33.33.to_d
    end
  end

  context "with $156k salary weekly, $5k bonus, $1k bonus ytd" do
    let(:i) { 3_000_00 }
    let(:p) { 52 }
    let(:b) { 5_000_00 }
    let(:b1) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 208_35.80.to_d
    end
  end

  # see https://docs.google.com/spreadsheets/d/1GwlJj9_1ilsRuOV5qPsQY-qFWXqkEEGzeshSq-sgjRg/edit?usp=sharing
  context "when there is a large bonus in the period" do
    let(:i) { 3_076_92 }
    let(:p) { 26 }
    let(:b) { 21_619_00 }
    let(:b1) { 0 }

    it "matches PDOC/Greg's sheet" do
      expect(k2p).to be_within(0.01).of 208_35.80.to_d
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
