# frozen_string_literal: true

RSpec.describe Taxman2024::On::T2 do
  let(:t2) { described_class.new(a: 53_494_99.16, t4: 2_106_91.97).amount }

  # see https://docs.google.com/spreadsheets/d/1q0tv_4IMqdL23wLRg49VikhXRC5tsy7oxGc5at71fzw/edit#gid=89378561
  it "matches PDOC/Greg's sheet" do
    expect(t2).to eq 2_706_91.97.to_d
  end
end
