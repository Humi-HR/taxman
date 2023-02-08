# frozen_string_literal: true

RSpec.describe Taxman2023::CppCalculator do
  let(:cpp_calc) { described_class.new(context: context) }
  let(:context) { { c: 427_13.to_d } }

  it "adds the employee cpp contribution to context" do
    expect(cpp_calc.calculate).to have_key :employee_cpp_contribution
  end

  it "adds the employer cpp contribution to context" do
    expect(cpp_calc.calculate).to have_key :employer_cpp_contribution
  end
end
