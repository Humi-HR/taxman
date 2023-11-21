# frozen_string_literal: true

RSpec.describe Taxman2024::F5 do
  let(:c) { 472_00.to_d }
  let(:c2) { 10_00.to_d }
  let(:f5) { described_class.new(c: c, c2: c2).amount }

  it "calculates the portion due to the enhanced cpp rate" do
    expect(f5).to be_within(0.01).of BigDecimal("89_32.77")
  end
end
