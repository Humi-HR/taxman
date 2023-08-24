# frozen_string_literal: true

RSpec.describe Taxman2023::PensionInput do
  let(:cpp_input) do
    described_class.new(
      pensionable_income_this_period: pi,
      ytd_cpp_contributions: cpp_ytd,
      ytd_qpp_contributions: qpp_ytd,
      contribution_months_this_year: pm
    )
  end

  let(:pi) { 3_500 }
  let(:cpp_ytd) { 114 }
  let(:qpp_ytd) { 441 }
  let(:pm) { 12 }

  let(:form) do
    {
      pi: 3_500_00.to_d,
      d: 114_00.to_d,
      b_pensionable: 0.to_d,
      pi_periodic: 3_500_00.to_d,
      dq: 441_00.to_d,
      pm: 12,
      qc_a5: 441_00.to_d,
      qc_b2_pensionable: 0.to_d,
      qc_s3: 3_500_00.to_d,
      qc_s3_periodic: 3_500_00.to_d,
      qc_r: 114_00.to_d
    }
  end

  it "converts its inputs into form" do
    expect(cpp_input.translate).to eq form
  end
end
