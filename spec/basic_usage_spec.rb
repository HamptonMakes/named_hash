require 'spec_helper'

RSpec.describe("Basic Usage") do
  it("should initialize using the helpers") do
    hash = _{{name: "Hampton"}}
    expect(hash["name"]).to eq("Hampton")
    expect(hash[:name]).to eq("Hampton")
    expect(hash[:Name]).to eq(nil)
  end
end