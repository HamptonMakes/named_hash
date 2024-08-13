require 'spec_helper'

RSpec.describe NamedHash do
  describe 'new empty NamedHashes' do
    subject { NamedHash.new }
    it "should have no data" do
      expect(subject["test"]).to be_nil
      expect(subject[:test]).to be_nil
    end

    it "should error on setting invalid key types" do
      expect {
        subject[123] = "test"
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

  describe 'initialized shallow with data' do
    subject { NamedHash.new(first_name: "Hampton", "last_name" => "Lintorn-Catlin", location: {
      city: "New Orleans",
      "state": "Louisiana"
    }) }

    describe "NamedHash#get" do
      it "use either key type" do
        expect(subject["first_name"]).to eq("Hampton")
        expect(subject[:first_name]).to eq("Hampton")

        # Another ass-covering mutation check by just ensuring I can query again without mutations
        expect(subject["first_name"]).to eq("Hampton")
        expect(subject[:first_name]).to eq("Hampton")
      end

      it "should return sub-hashes" do
        expect(subject["location"]).to be_a(Hash)
        expect(subject[:location]).to be_a(Hash)
      end

      it "should return nil if it's an invalid key type" do
        expect(subject[123]).to be_nil
        # It might seem dumb, but doing it twice to ensure no mutations whatsoever
        expect(subject[123]).to be_nil
      end
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

    describe 'missing keys' do
      it 'should return null for missing keys of all types' do
        empty = ~{}
        expect(empty[:values]).to eq(nil)
        expect(empty["whatever"]).to eq(nil)
        expect(empty[:weekly_sales]).to eq(nil)
      end
    end
  end

  describe 'NamedHash#fetch'
end
