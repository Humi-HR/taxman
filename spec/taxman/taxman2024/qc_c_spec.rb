# frozen_string_literal: true

RSpec.describe Taxman2024::QcC do
  subject(:c) { described_class.new(p: p, qc_a5: qc_a5, qc_s3: qc_s3, qc_r: qc_r, pm: pm).amount }

  let(:p) { 12 }
  let(:qc_r) { 0 }
  let(:pm) { 12 }

  context "when the employee has already reached the qpp maximum for the year" do
    let(:qc_a5) { Taxman2024::Qpp::MAX }
    let(:qc_s3) { 4_000_00 }

    it "calculates zero qpp contribution for this period" do
      expect(c).to be_zero
    end
  end

  context "when the employee will meet and exceed the maximum this period" do
    let(:qc_a5) { Taxman2024::Qpp::MAX - 100_00 }
    let(:qc_s3) { 4_000_00 }

    it "calculates a qpp contribution of the remaining room" do
      expect(c).to eq 100_00
    end
  end

  context "when the employee has zero income in the period" do
    let(:qc_a5) { 0 }
    let(:qc_s3) { 0 }

    it "calculates zero qpp contribution for the period" do
      expect(c).to be_zero
    end
  end

  context "with a $5.5k salary monthly" do
    let(:qc_a5) { 0 }
    let(:qc_s3) { 5_500_00 }

    it "matches the WEBRAs expectation" do
      expect(c).to be_within(0.01).of 333_33.to_d
    end
  end

  context "with a $5.5k salary monthly and previous CPP contributions" do
    let(:qc_a5) { 0 }
    let(:qc_s3) { 5_500_00 }
    let(:qc_r) { 1_000_00 }

    it "matches the WEBRAS expectation" do
      expect(c).to be_within(0.01).of 333_33.to_d
    end
  end

  context "with a $5.5k salary monthly and max CPP contributions" do
    let(:qc_a5) { 0 }
    let(:qc_s3) { 5_500_00 }
    let(:qc_r) { Taxman2024::Cpp::MAX }

    it "matches the WEBRAS expectation" do
      expect(c).to be_within(0.01).of 0.to_d
    end
  end

  context "with a $5.5k salary monthly and max CPP contributions less $100" do
    let(:qc_a5) { 0 }
    let(:qc_s3) { 5_500_00 }
    let(:qc_r) { Taxman2024::Cpp::MAX - 100_00 }

    it "matches the WEBRAS expectation" do
      expect(c).to be_within(0.01).of 107_56.to_d
    end
  end
end
