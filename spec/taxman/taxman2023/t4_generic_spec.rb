# frozen_string_literal: true

RSpec.describe Taxman2023::T4Generic do
  let(:t4) { described_class.new(a: 0, hd: 0, k2p: 0, tcp: nil, k3p: 0) }

  it "can be instantiated" do
    expect(t4).to be_an_instance_of(described_class)
  end

  it "must be subclassed to call amount" do
    expect { t4.amount }.to raise_error NameError
  end
end
