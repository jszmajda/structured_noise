module StructuredNoise
  class CLI
    def initialize(scriptname, args)
      @options = StructuredNoise::Options.new(scriptname, args)
    end

    def run!
      die_if_no_schema!

      operating_environment.load_schema
      operating_environment.generate_output
    end

    def operating_environment
      @operating_environment ||=
        StructuredNoise::Generator.new(
          schema: @options.schema,
          base64: @options.base64,
          messages_per_second: @options.messages_per_second
      )
    end

    def die_if_no_schema!
      unless @options.schema
        puts "Please define a schema."
        puts ""
        puts @options.parser
        exit
      end
    end
  end
end
