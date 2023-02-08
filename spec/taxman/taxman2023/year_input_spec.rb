# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
RSpec.describe Taxman2023::YearInput do
  let(:year_input) do
    described_class.new(
      ytd_bonus: 1,
      annual_deductions: 2, # F1
      ytd_rsp_bonus_deductions: 3, # F4
      pay_periods: 12,
      f5b_ytd: 4
    )
  end

  it "translates the inputs" do
    expect(year_input.translate).to eq(
      {
        b1: 1_00.to_d,
        f1: 2_00.to_d,
        f4: 3_00.to_d,
        p: 12,
        f5b_ytd: 4_00.to_d
      }
    )
  end

  context "without optional params" do
    let(:year_input) { described_class.new(ytd_bonus: 1, f5b_ytd: 2, pay_periods: 26) }

    it "has default values" do
      expect(year_input.translate).to eq(
        {
          b1: 1_00.to_d,
          f5b_ytd: 2_00.to_d,
          p: 26,
          f1: 0,
          f4: 0
        }
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength
