# frozen_string_literal: true

RSpec.describe Taxman2024::F5Q do
  let(:qc_c) { 472_00.to_d }
  let(:qc_c2) { 10_00.to_d }
  let(:f5) { described_class.new(qc_c: qc_c, qc_c2: qc_c2).amount }

  it "calculates the portion due to the enhanced cpp rate" do
    expect(f5).to be_within(0.01).of BigDecimal("83_75.00")
  end
end
