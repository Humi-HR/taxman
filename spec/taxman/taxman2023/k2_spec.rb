# frozen_string_literal: true

RSpec.describe Taxman2023::K2 do
  let(:k2) { described_class.new(i: i, b: b, b1: b1, p: p).amount }
  let(:b1) { 0 }

  context "with $54k salary monthly, $1k bonus" do
    let(:i) { 4_500_00 }
    let(:p) { 12 }
    let(:b) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2).to eq 516_86.25.to_d
    end
  end

  context "with $54k salary monthly, $1k bonus, $1k ytd bonus" do
    let(:i) { 4_500_00 }
    let(:p) { 12 }
    let(:b) { 1_000_00 }
    let(:b1) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2).to eq 526_73.25.to_d
    end
  end

  context "with $156k salary weekly, $5k bonus, $1k bonus ytd" do
    let(:i) { 3_000_00 }
    let(:p) { 52 }
    let(:b) { 5_000_00 }
    let(:b1) { 1_000_00 }

    it "matches PDOC/Greg's sheet" do
      expect(k2).to eq 618_88.50.to_d
    end
  end

  # see https://docs.google.com/spreadsheets/d/1GwlJj9_1ilsRuOV5qPsQY-qFWXqkEEGzeshSq-sgjRg/edit?usp=sharing
  context "when there is a large bonus in the period" do
    let(:i) { 3_076_92 }
    let(:p) { 26 }
    let(:b) { 21_619_00 }
    let(:b1) { 0 }

    it "matches PDOC/Greg's sheet" do
      expect(k2).to eq 618_88.50.to_d
    end
  end
end
