# frozen_string_literal: true

RSpec.describe Taxman2023::QcAp do
  subject(:c) { described_class.new(qc_a6: qc_a6, qc_s4: qc_s4).amount }

  context "when the employee has already reached the qpip maximum for the year" do
    let(:qc_a6) { Taxman2023::Qpip::EMPLOYEE_MAX }
    let(:qc_s4) { 5_000_00 }

    it "calculates zero qpip contribution for this period" do
      expect(c).to be_zero
    end
  end

  context "when the employee has reached qpip maximum for the year less $100" do
    let(:qc_a6) { Taxman2023::Qpip::EMPLOYEE_MAX - 100_00 }
    let(:qc_s4) { 5_000_00 }

    it "calculates zero qpip contribution for this period" do
      expect(c).to eq 100_00
    end
  end

  context "when the employee has reached qpip maximum for the year less $100 and low income" do
    let(:qc_a6) { Taxman2023::Qpip::EMPLOYEE_MAX - 100_00 }
    let(:qc_s4) { 50_00 }

    it "calculates zero qpip contribution for this period" do
      expect(c).to eq 2_47
    end
  end
end
