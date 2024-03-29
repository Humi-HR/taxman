# frozen_string_literal: true

RSpec.describe Taxman2023::C do
  subject(:c) { described_class.new(pi: pi, p: p, pm: pm, d: d, b_pensionable: b_pensionable, dq: dq).amount }

  let(:p) { 12 }
  let(:pm) { 12 }
  let(:b_pensionable) { 0 }
  let(:dq) { 0 }

  context "when the employee has already reached the cpp maximum for the year" do
    let(:d) { Taxman2023::Cpp::MAX }
    let(:pi) { 4_000_00 }

    it "calculates zero cpp contribution for this period" do
      expect(c).to be_zero
    end
  end

  context "when the employee will meet and exceed the maximum this period" do
    let(:d) { Taxman2023::Cpp::MAX - 100_00 }
    let(:pi) { 4_000_00 }

    it "calculates a cpp contribution of the remaining room" do
      expect(c).to eq 100_00
    end
  end

  context "when the employee has zero income in the period" do
    let(:d) { 0 }
    let(:pi) { 0 }

    it "calculates zero cpp contribution for the period" do
      expect(c).to be_zero
    end
  end

  context "with a $54k salary monthly and a $1k bonus" do
    let(:d) { 0 }
    let(:pi) { 5_500_00 }

    it "matches the PDOC expectation" do
      expect(c).to be_within(0.01).of 309_89.58.to_d
    end
  end

  context "with a $5.5k salary monthly and previous QPP contributions" do
    let(:d) { 0 }
    let(:pi) { 5_500_00 }
    let(:dq) { 1_000_00 }

    it "matches the PDOC expectation" do
      expect(c).to be_within(0.01).of 309_89.58.to_d
    end
  end

  context "with a $5.5k salary monthly and max QPP contributions" do
    let(:d) { 0 }
    let(:pi) { 5_500_00 }
    let(:dq) { Taxman2023::Qpp::MAX }

    it "matches the PDOC expectation" do
      expect(c).to be_within(0.01).of 0.to_d
    end
  end

  context "with a $5.5k salary monthly and max QPP contributions less $100" do
    let(:d) { 0 }
    let(:pi) { 5_500_00 }
    let(:dq) { Taxman2023::Qpp::MAX - 100_00 }

    it "matches the PDOC expectation" do
      expect(c).to be_within(0.2).of 92_97.to_d
    end
  end
end
