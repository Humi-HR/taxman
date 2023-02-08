# frozen_string_literal: true

RSpec.describe Taxman2023::T do
  let(:t) { described_class.new(t1: 2_000_00, t2: 1_000_00, p: 12, l: 50_00).amount }

  it "divides the taxes among the periods" do
    expect(t).to eq 300_00.to_d
  end
end
