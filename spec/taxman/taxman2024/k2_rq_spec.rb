# frozen_string_literal: true

# No reference implementation for now

# RSpec.describe Taxman2024::K2RQ do
#   let(:k2rq) { described_class.amount(**k2rq_params) }
#   let(:k2rq_params) do
#     {
#       p: p,
#       c: c,
#       pm: pm,
#       d: d,
#       ei: ei,
#       ie: ie
#     }
#   end
#   let(:p) { 12 }
#   let(:c) { 500_00 }
#   let(:pm) { 12 }
#   let(:d) { 500 }
#   let(:ei) { 500 }
#   let(:ie) { 500 }
#
#   it "returns correct value" do
#     expect(k2rq).to be_within(0.01).of 52_037.27.to_d
#   end
#
#   context "without d, ei and dq inputs" do
#     let(:d) { 0 }
#     let(:ei) { 0 }
#     let(:dq) { 0 }
#
#     context "with more than max qpp credits" do
#       it "return max qpp credits" do
#         expect(k2rq).to be_within(0.01).of 51_155.55.to_d
#       end
#     end
#
#     context "with less than max qpp credits" do
#       let(:c) { 100 }
#
#       it "return correct value" do
#         expect(k2rq).to be_within(0.01).of 194.29.to_d
#       end
#     end
#   end
# end
