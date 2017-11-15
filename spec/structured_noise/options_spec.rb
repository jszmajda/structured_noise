require 'spec_helper'

RSpec.describe StructuredNoise::Options do
  subject { StructuredNoise::Options.new("scriptname", @args) }

  describe "--schema" do
    it "parses --schema filename into the file" do
      @args = ["--schema", "thing"]
      expect(subject.schema).to eq("thing")
    end
  end

  describe "--base64" do
    it "parses a lack of --base64 into false" do
      @args = []
      expect(subject.base64).to be false
    end

    it "parses --base64 into true" do
      @args = ["--base64"]
      expect(subject.base64).to be true
    end
  end

  describe "--messages-per-second" do
    it "parses --messages-per-second N into a number" do
      @args = ["--messages-per-second", "42"]
      expect(subject.messages_per_second).to eq(42)
    end

    it "allows for floats" do
      @args = ["--messages-per-second", "4.2"]
      expect(subject.messages_per_second).to eq(4.2)
    end
  end
end
