# frozen_string_literal: true

RSpec.describe Taxman2022::Cpp do
  let(:constants) { described_class::Constants.to_h }

  it "has the maximum pensionable income for a year" do
    expect(constants[:cpp_maximum_pensionable]).to eq 64_900.00
  end

  it "has the basic exemption" do
    expect(constants[:cpp_basic_exemption]).to eq 3_500.00
  end

  it "has the employee rate" do
    expect(constants[:cpp_employee_rate]).to eq 0.0570
  end

  it "has the employer matching rate" do
    expect(constants[:cpp_employer_matching]).to eq 1
  end
end
