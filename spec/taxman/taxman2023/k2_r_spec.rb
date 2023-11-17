# frozen_string_literal: true

# No reference implementation for now

# RSpec.describe Taxman2023::K2R do
#   let(:k2r) { described_class.amount(**k2r_params) }
#
#   let(:k2r_params) do
#     {
#       p: p,
#       c: c,
#       pm: pm,
#       dq: dq,
#       ei: ei
#     }
#   end
#   let(:p) { 12 }
#   let(:c) { 500_00 }
#   let(:pm) { 12 }
#   let(:dq) { 500 }
#   let(:ei) { 500 }
#
#   it "returns correct value" do
#     expect(k2r).to be_within(0.01).of 47_757.02.to_d
#   end
#
#   context "without ei and dq inputs" do
#     let(:ei) { 0 }
#     let(:dq) { 0 }
#
#     context "with more than max qpp credits" do
#       it "return max qpp credits" do
#         expect(k2r).to be_within(0.01).of 46_851.75.to_d
#       end
#     end
#
#     context "with less than max qpp credits" do
#       let(:c) { 100 }
#
#       it "return correct value" do
#         expect(k2r).to be_within(0.01).of 149.74.to_d
#       end
#     end
#   end
# end
