require 'spec_helper'

describe StructuredNoise::Generator do
  describe "#load_schema" do
    it "loads the proper Avro schama" do
      gen = StructuredNoise::Generator.new(schema: "spec/Sample.avsc")
      schema = gen.load_schema
      expect(schema).to be_instance_of(Avro::Schema::RecordSchema)
      expect(schema.namespace).to eq "com.company"
    end
  end
end
