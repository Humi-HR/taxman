# frozen_string_literal: true

RSpec.describe Taxman2024::C2 do
  subject(:c2) { described_class.new(pm: pm, d2: d2, pi_ytd: pi_ytd, pi: pi, w: w.amount).amount }

  let(:pm) { 12 }
  let(:p) { 12 }
  let(:w) { Taxman2024::W.new(pm: pm, pi_ytd: pi_ytd) }
  let(:pi) { 4_000_00 }
  let(:d2) { 0 }
  let(:pi_ytd) { 0 }

  context "when the employee has not reached the CPP maximum for the year" do
    it "calculates zero CPP2 for this period" do
      expect(c2).to be_zero
    end
  end

  context "when the employee has reached the CPP maximum for the year" do
    let(:pi_ytd) { Taxman2024::Cpp::MAXIMUM_PENSIONABLE }

    it "calculates non-zero CPP2 for this period" do
      expect(c2).not_to be_zero
    end

    context "when the employee has reached the CPP2 maximum for the year" do
      let(:d2) { Taxman2024::Cpp::MAX_ADDITIONAL }

      it "calculates zero CPP2 for this period" do
        expect(c2).to be_zero
      end
    end
  end
end
