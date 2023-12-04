# frozen_string_literal: true

RSpec.describe Taxman2024::EiInput do
  let(:ei_input) do
    described_class.new(
      insurable_income_this_period: ie,
      employees_ytd_contributions: d1,
      insurable_non_periodic_income_this_period: b_insurable
    )
  end

  let(:ie) { 3_500 }
  let(:d1) { 1_000 }
  let(:b_insurable) { 500 }

  let(:cra_form) do
    {
      ie: 3_500_00.to_d,
      d1: 1_000_00.to_d,
      b_insurable: 500_00.00.to_d,
      ie_periodic: 3_000_00.to_d
    }
  end

  it "converts its inputs into CRA form" do
    expect(ei_input.translate).to eq cra_form
  end
end
