# frozen_string_literal: true

RSpec.describe Taxman2023::QppInput do
  let(:qpp_input) do
    described_class.new(
      pensionable_income_this_period: s3,
      pensionable_non_periodic_income_this_period: b2_pensionable,
      ytd_contributions: a5
    )
  end

  let(:s3) { 3_500 }
  let(:a5) { 114 }
  let(:b2_pensionable) { 500 }

  let(:revenue_form) do
    {
      qc_s3: 3_500_00.to_d,
      qc_a5: 114_00.to_d,
      qc_b2_pensionable: 500_00.to_d,
      qc_s3_periodic: 3_000_00.to_d
    }
  end

  it "converts its inputs into Revenue Quebec form" do
    expect(qpp_input.translate).to eq revenue_form
  end
end
