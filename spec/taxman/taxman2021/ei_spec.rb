# frozen_string_literal: true

RSpec.describe Taxman2021::Ei do
  let(:constants) { described_class::Constants.to_h }

  it "has the employee rate" do
    expect(constants[:ei_employee_rate]).to eq 0.0158
  end

  it "has the employer matching rate" do
    expect(constants[:ei_employer_matching]).to eq 1.4
  end

  it "has the maximum insurable earnings for a year" do
    expect(constants[:ei_maximum_insurable]).to eq 56_300.00
  end
end
