# frozen_string_literal: true

RSpec.describe Taxman2023::F5 do
  let(:c) { 472_00.to_d }
  let(:f5) { described_class.new(c: c).amount }

  it "calculates the portion due to the enhanced cpp rate" do
    expect(f5).to be_within(0.01).of BigDecimal("79_32.77")
  end
end
