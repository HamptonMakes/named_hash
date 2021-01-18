require 'spec_helper'

RSpec.describe "Named Hash Method Integration" do
  def living_legend(arg1, options={})
    options = _{options}

    options[:living_legend] = true
    options
  end

  it "should work as a default hash" do
    phyllis = living_legend(1917, name: "Phyllis Diller")
    expect(phyllis["name"]).to eq("Phyllis Diller")
    expect(phyllis["living_legend"]).to be_truthy
  end
end