# frozen_string_literal: true

RSpec.describe Taxman2023::T3 do
  let(:t3) { described_class.new(a: a).amount }

  context "with no income" do
    let(:a) { 0 }

    it "calculates no taxes" do
      expect(t3).to eq 0
    end
  end
end
