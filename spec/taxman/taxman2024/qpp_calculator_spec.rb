# frozen_string_literal: true

RSpec.describe Taxman2024::QppCalculator do
  let(:qpp_calc) { described_class.new(context: context) }

  context "when paying taxes in Quebec" do
    let(:context) { { qc_c: 427_13.to_d, province: Taxman::QC } }

    it "adds the employee Qpp contribution to context" do
      expect(qpp_calc.calculate).to match(
        a_hash_including(employee_qpp_contribution: 427.13.to_d)
      )
    end

    it "adds the employer qpp contribution to context" do
      expect(qpp_calc.calculate).to match(
        a_hash_including(employer_qpp_contribution: 427.13.to_d)
      )
    end
  end

  context "when paying taxes outside of Quebec" do
    let(:context) { { qc_c: 427_13.to_d, province: "DK" } }

    it "adds the employee Qpp contribution to context" do
      expect(qpp_calc.calculate).to match(
        a_hash_including(employee_qpp_contribution: 0.to_d)
      )
    end

    it "adds the employer qpp contribution to context" do
      expect(qpp_calc.calculate).to match(
        a_hash_including(employer_qpp_contribution: 0.to_d)
      )
    end
  end
end
