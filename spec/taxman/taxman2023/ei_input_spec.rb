# frozen_string_literal: true

RSpec.describe Taxman2023::EiInput do
  let(:ei_input) do
    described_class.new(
      insurable_income_this_period: ie,
      employees_ytd_contributions: d1
    )
  end

  let(:ie) { 3_500 }
  let(:d1) { 1_000 }

  it "converts its inputs into CRA form" do
    expect(ei_input.translate).to eq({ ie: 3_500_00.to_d, d1: 1_000_00.to_d })
  end
end
