# frozen_string_literal: true

# rubocop:disable RSpec/ExampleLength
# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Taxman2023::Td1Input do
  let(:td1_input) do
    described_class.new(
      federal_personal_amount: tc,
      provincial_personal_amount: tcp,
      federal_personal_amount_offset: tc_offset,
      provincial_personal_amount_offset: tcp_offset,
      deduction_for_zone: hd,
      additional_tax_deductions: l
    )
  end

  context "with inputs" do
    let(:tc) { 15_000 }
    let(:tcp) { 12_000 }
    let(:tc_offset) { 1 }
    let(:tcp_offset) { 2 }
    let(:hd) { 4 }
    let(:l) { 5 }

    it "translates the inputs" do
      expect(td1_input.translate).to eq(
        {
          tc: 15_000_00.to_d,
          tcp: 12_000_00.to_d,
          tc_offset: 1_00.to_d,
          tcp_offset: 2_00.to_d,
          hd: 4_00.to_d,
          l: 5_00.to_d
        }
      )
    end
  end

  context "with no params" do
    let(:td1_input) { described_class.new }

    it "has default values" do
      expect(td1_input.translate).to eq(
        {
          tc: nil,
          tcp: nil,
          tc_offset: 0,
          tcp_offset: 0,
          hd: 0,
          l: 0
        }
      )
    end
  end
end
# rubocop:enable RSpec/ExampleLength
# rubocop:enable RSpec/MultipleMemoizedHelpers
