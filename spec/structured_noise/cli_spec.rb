require 'spec_helper'

describe StructuredNoise::CLI do
  it "exists I guess" do
    StructuredNoise::CLI
  end

  describe "construction" do
    it "takes the name of the script and the args" do
      StructuredNoise::CLI.new("script", ["args"])
      #???
    end
  end
end
