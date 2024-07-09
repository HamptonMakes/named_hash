require 'spec_helper'

RSpec.describe NamedHash do
  describe 'new empty NamedHashes' do
    subject { NamedHash.new }
    it "should have no data" do
      expect(subject["test"]).to be_nil
      expect(subject[:test]).to be_nil
    end

    it "should error on invalid key types" do
      expect {
        subject[123]
      }.to raise_error NamedHash::InvalidKeyError
    end

    it 'should allow of setting string keys with indifferent recall' do
      subject['name'] = "Hampton"
      expect(subject['name']).to eq("Hampton")
      expect(subject[:name]).to eq("Hampton")
    end

    it 'should allow of setting symbol keys with indifferent recall' do
      subject[:name] = "Hampton"
      expect(subject['name']).to eq("Hampton")
      expect(subject[:name]).to eq("Hampton")
    end
  end

  describe 'initialized with data' do
    subject { NamedHash.new(first_name: "Hampton", "last_name" => "Lintorn-Catlin", location: {
      city: "New Orleans",
      "state": "Louisiana"
    }) }

    it "should have data" do
      expect(subject["first_name"]).to eq("Hampton")
      expect(subject[:first_name]).to eq("Hampton")
    end

    it "should error on invalid key types" do
      expect {
        subject[123]
      }.to raise_error NamedHash::InvalidKeyError
    end

    describe "should overwrite existing keys" do
      it "should do this with strings" do
        subject["first_name"] = "Michael"
        expect(subject["first_name"]).to eq("Michael")
        expect(subject[:first_name]).to eq("Michael")
      end


      it "should do this with symbols" do
        subject[:first_name] = "Michael"
        expect(subject["first_name"]).to eq("Michael")
        expect(subject[:first_name]).to eq("Michael")
      end
    end
  end
end