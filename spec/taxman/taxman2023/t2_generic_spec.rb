# frozen_string_literal: true

RSpec.describe Taxman2023::T2Generic do
  let(:t2) { described_class.new(a: 0, t4: 1_234_00).amount }

  it "has the same value as T4 when not subclassed" do
    expect(t2).to eq 1_234_00.to_d
  end
end
