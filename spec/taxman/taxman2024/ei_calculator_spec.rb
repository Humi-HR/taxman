# frozen_string_literal: true

RSpec.describe Taxman2024::EiCalculator do
  let(:ei_calculator) { described_class.new(context: context).calculate }
  let(:context) { { ei: 54_78.to_d } }

  it "adds the employee contribution to the context" do
    expect(ei_calculator).to match(
      a_hash_including(employee_ei_contribution: 54.78.to_d)
    )
  end

  it "adds the employer contribution to the context" do
    expect(ei_calculator).to match(
      a_hash_including(employer_ei_contribution: (1.4 * 54.78.to_d).round(2))
    )
  end

  context "with a cusom employer ei multiple" do
    let(:context) { { ei: 12_34.to_d, employer_ei_multiple: 1.0 } }

    it "handles the custom employer ei multiple" do
      expect(ei_calculator).to match(
        a_hash_including(employer_ei_contribution: 12.34.to_d)
      )
    end
  end
end
