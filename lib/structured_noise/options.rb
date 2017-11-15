require 'optparse'

module StructuredNoise
  class Options
    attr_accessor :schema, :base64, :messages_per_second
    attr_reader :parser

    def initialize(scriptname, args)
      @base64 = false
      @parser = build_parser(scriptname)
      @parser.parse!(args)
    end

    private

    def build_parser(scriptname)
      this = self
      OptionParser.new do |opt|
        opt.banner = "Usage: #{scriptname} [OPTIONS]"
        opt.separator ""
        opt.separator "Options:"

        opt.on("--schema SCHEMA", "avro schema (.avsc) file to load") do |schema_file|
          this.schema = schema_file
        end

        opt.on("--base64", "encode output as base64") do |b64|
          this.base64 = true
        end

        opt.on("--messages-per-second SECONDS", "how many messages to send per second") do |mps|
          this.messages_per_second = mps.to_f
        end
      end
    end
  end
end
