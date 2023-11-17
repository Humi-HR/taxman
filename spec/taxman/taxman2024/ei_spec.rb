# frozen_string_literal: true

RSpec.describe Taxman2024::Ei do
  let(:ei) do
    described_class.amount(ie: ie, d1: d1, ie_ytd: ie_ytd, province: province,
                           moved_in_or_out_qc: moved_in_or_out_qc)
  end
  let(:d1) { 0 }
  let(:ie) { 0 }
  let(:ie_ytd) { 0 }
  let(:province) { Taxman::BC }
  let(:moved_in_or_out_qc) { false }

  context "when ei contribution limit has already been reached" do
    let(:d1) { Taxman2024::Ei::EI_MAX }

    it "calculates zero contribution" do
      expect(ei).to be_zero
    end
  end

  context "when there is no insurable income in the period" do
    it "calculates zero contribution" do
      expect(ei).to be_zero
    end
  end

  context "with a $51k salary and a $1k bonus" do
    let(:ie) { 5_500_00 }

    it "matches pdoc" do
      expect(ei).to eq 89_65.00.to_d
    end
  end

  context "when the contribution limit will be met and exceeded this period" do
    let(:d1) { Taxman2024::Ei::EI_MAX - 50_00 }
    let(:ie) { 4_000_00 }

    it "uses the remaining contribution room" do
      expect(ei).to eq 50_00
    end
  end

  context "when having moved from Ontario to Quebec" do
    let(:ie) { 4_000_00 }
    let(:ie_ytd) { 60_000_00 }
    let(:moved_in_or_out_qc) { true }
    let(:province) { Taxman::QC }

    it "uses the remaining contribution room" do
      expect(ei).to eq 19_05
    end
  end

  describe "constants" do
    let(:constants) { described_class::Constants.to_h }

    it "has the employee rate" do
      expect(constants[:ei_employee_rate]).to eq 0.0163
    end

    it "has the employer matching rate" do
      expect(constants[:ei_employer_matching]).to eq 1.4
    end

    it "has the maximum insurable earnings for a year" do
      expect(constants[:ei_maximum_insurable]).to eq 61_500.00
    end
  end
end
