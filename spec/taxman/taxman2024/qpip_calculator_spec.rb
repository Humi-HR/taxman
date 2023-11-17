# frozen_string_literal: true

RSpec.describe Taxman2024::QpipCalculator do
  let(:qpip_calc) { described_class.new(context: context) }

  context "when paying taxes in Quebec" do
    let(:context) { { qc_ap: 427_13.to_d, qc_ap1: 524_24.to_d, province: Taxman::QC } }

    it "adds the employee Qpp contribution to context" do
      expect(qpip_calc.calculate).to match(
        a_hash_including(employee_qpip_contribution: 427.13.to_d)
      )
    end

    it "adds the employer qpip contribution to context" do
      expect(qpip_calc.calculate).to match(
        a_hash_including(employer_qpip_contribution: 524.24.to_d)
      )
    end
  end

  context "when paying taxes outside of Quebec" do
    let(:context) { { qc_ap: 427_13.to_d, qc_ap1: 524_24.to_d, province: "DK" } }

    it "adds the employee Qpp contribution to context" do
      expect(qpip_calc.calculate).to match(
        a_hash_including(employee_qpip_contribution: 0.to_d)
      )
    end

    it "adds the employer qpip contribution to context" do
      expect(qpip_calc.calculate).to match(
        a_hash_including(employer_qpip_contribution: 0.to_d)
      )
    end
  end
end
