# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe Taxman2023::PeriodInput do
  let(:period_input) do
    described_class.new(
      taxable_periodic_income: 1,
      taxable_non_periodic_income: 2,
      rsp_deductions: 3,
      alimony: 5,
      rsp_deductions_from_bonus: 6,
      previous_taxable_periodic_income: 7,
      union_dues: 9,
      province: "on"
    )
  end

  it "translates the inputs" do
    expect(period_input.translate).to eq(
      {
        i: 1_00.to_d,
        b: 2_00.to_d,
        f: 3_00.to_d,
        f2: 5_00.to_d,
        f3: 6_00.to_d,
        previous_i: 7_00.to_d,
        u1: 9_00.to_d,
        province: "ON",
        qc_g: 1_00.to_d,
        qc_d: 1_00.to_d,
        qc_b2: 2_00.to_d
      }
    )
  end

  context "with optional params absent" do
    let(:period_input) do
      described_class.new(
        taxable_periodic_income: 50,
        taxable_non_periodic_income: 100,
        province: "on"
      )
    end

    it "has default values" do
      expect(period_input.translate).to eq(
        {
          i: 50_00.to_d,
          previous_i: 0.to_d,
          b: 100_00.to_d,
          f: 0.to_d,
          f2: 0.to_d,
          f3: 0.to_d,
          u1: 0.to_d,
          province: "ON",
          qc_g: 50_00.to_d,
          qc_d: 50_00.to_d,
          qc_b2: 100_00.to_d  
        }
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength
