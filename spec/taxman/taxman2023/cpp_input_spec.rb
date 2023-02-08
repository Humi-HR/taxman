# frozen_string_literal: true

RSpec.describe Taxman2023::CppInput do
  let(:cpp_input) do
    described_class.new(
      pensionable_income_this_period: pi,
      ytd_contributions: ytd,
      contribution_months_this_year: pm
    )
  end

  let(:pi) { 3_500 }
  let(:ytd) { 114 }
  let(:pm) { 12 }

  it "converts its inputs into CRA form" do
    expect(cpp_input.translate).to eq({ pi: 3_500_00.to_d, d: 114_00.to_d, pm: 12 })
  end
end
