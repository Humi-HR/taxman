# frozen_string_literal: true

RSpec.describe Taxman2023::K2Q do
  let(:k2q) { described_class.amount(**k2q_params) }
  let(:k2q_params) do
    {
      p: p,
      c: c,
      pm: pm,
      ei: ei,
      ie: ie
    }
  end
  let(:p) { 12 }
  let(:c) { 500_00 }
  let(:pm) { 12 }
  let(:ei) { 500 }
  let(:ie) { 500 }

  it "returns correct value" do
    expect(k2q).to be_within(0.01).of 52_055.55.to_d
  end

  context "without ei and ie inputs" do
    let(:ei) { 0 }
    let(:ie) { 0 }

    context "with more than max qpp credits" do
      it "return max qpp credits" do
        expect(k2q).to be_within(0.01).of 51_111.0.to_d
      end
    end

    context "with less than max qpp credits" do
      let(:c) { 100 }

      it "return correct value" do
        expect(k2q).to be_within(0.01).of 151.87.to_d
      end
    end
  end
end
