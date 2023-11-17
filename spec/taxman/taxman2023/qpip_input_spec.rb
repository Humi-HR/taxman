# frozen_string_literal: true

RSpec.describe Taxman2023::QpipInput do
  let(:qpip_input) do
    described_class.new(
      parental_insurable_income_this_period: s4,
      ytd_employee_contributions: a6,
      ytd_employer_contributions: a7
    )
  end

  let(:s4) { 3_500 }
  let(:a6) { 114 }
  let(:a7) { 441 }

  let(:revenue_form) do
    {
      qc_s4: 3_500_00.to_d,
      qc_a6: 114_00.to_d,
      qc_a7: 441_00.to_d
    }
  end

  it "converts its inputs into Revenue Quebec form" do
    expect(qpip_input.translate).to eq revenue_form
  end
end
