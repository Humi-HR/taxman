# frozen_string_literal: true

RSpec.describe Taxman2024::CppCalculator do
  let(:cpp_calc) { described_class.new(context: context) }
  let(:context) { { c: 427_13.to_d, c2: 10_00.to_d } }

  it "adds the employee cpp contribution to context" do
    expect(cpp_calc.calculate).to match(
      a_hash_including(employee_cpp_contribution: 437.13.to_d)
    )
  end

  it "adds the employer cpp contribution to context" do
    expect(cpp_calc.calculate).to match(
      a_hash_including(employer_cpp_contribution: 437.13.to_d)
    )
  end
end
