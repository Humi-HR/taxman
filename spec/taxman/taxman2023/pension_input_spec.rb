# frozen_string_literal: true

RSpec.describe Taxman2023::PensionInput do
  let(:cpp_input) do
    described_class.new(
      pensionable_income_this_period: pi,
      ytd_cpp_contributions: cpp_ytd,
      ytd_qpp_contributions: qpp_ytd,
      contribution_months_this_year: pm,
      pensionable_non_periodic_income_this_period: b_pensionable,
      qc_pensionable_income_this_period: qc_s3,
      qc_pensionable_non_periodic_income_this_period: qc_b2_pensionable
    )
  end

  let(:pi) { 3_500 }
  let(:cpp_ytd) { 114 }
  let(:qpp_ytd) { 441 }
  let(:pm) { 12 }
  let(:b_pensionable) { 111 }
  let(:qc_s3) { 555 }
  let(:qc_b2_pensionable) { 333 }

  let(:form) do
    {
      pi: 3_500_00.to_d,
      d: 114_00.to_d,
      b_pensionable: 111_00.to_d,
      pi_periodic: 3_389_00.to_d,
      dq: 441_00.to_d,
      pm: 12,
      qc_a5: 441_00.to_d,
      qc_b2_pensionable: 333_00.to_d,
      qc_s3: 555_00.to_d,
      qc_s3_periodic: 222_00.to_d,
      qc_r: 114_00.to_d
    }
  end

  it "converts its inputs into form" do
    expect(cpp_input.translate).to eq form
  end
end
