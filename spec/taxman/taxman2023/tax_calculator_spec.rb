# frozen_string_literal: true

RSpec.describe Taxman2023::TaxCalculator do
  let(:partial_context) do
    {
      p: 52,
      i: 3_000_00.to_d,
      f: 0,
      f2: 0,
      f5a: 29_74.79.to_d,
      u1: 0,
      hd: 0,
      f1: 0,
      b: 5_000_00.to_d,
      f3: 0,
      f5b: 49_57.98.to_d,
      b1: 1_000_00.to_d,
      f4: 0,
      f5b_ytd: 9_63.to_d,
      c: 472_00.to_d,
      province: "ON",
      k3: 0, # Other authorized per period federal deductions
      k3p: 0, # Other authorized per period provincial deductions
      l: 0
    }
  end
  let(:context) do
    {
      a: Taxman2023::A.new(**partial_context.slice(*Taxman2023::A.params)).amount
    }.merge(partial_context)
  end

  let(:tax) { described_class.new(context: context).calculate }

  it "matches the federal taxes on PDOC/Greg's sheet" do
    expect(tax[:federal_tax]).to be_within(0.1).of 543.84.to_d
  end

  it "matches the provincial taxes on PDOC/Greg's sheet" do
    expect(tax[:provincial_tax]).to be_within(0.1).of 321.17.to_d
  end

  context "when a required parameter is missing" do
    let(:tax) { described_class.new(context: partial_context).calculate }

    it "raises an error" do
      expect { tax }.to raise_error Taxman::ContextMissing
    end
  end
end
