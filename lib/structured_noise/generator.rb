require 'json'
require 'avro'
require 'avro-patches'
require 'base64'
module StructuredNoise
  class Generator
    MAGIC_BYTE = [0].pack("C").freeze

    def initialize(schema:, base64: false, messages_per_second: 0)
      @schema_file_name = schema
      @output_base64 = base64
      @messages_per_second = messages_per_second
      @schemas = {}
    end

    def load_schema
      json = JSON.parse(File.read(canonical_schema_file_name))
      @schema_name = json["name"]
      @namespace = json["namespace"] || ""

      @avro_schema = Avro::Schema.real_parse(json)
    end

    def generate_output
      with_timing do
        message = encode(generate_random_fields)
        if @output_base64
          message = Base64.encode64(message)
        end
        puts message
      end
    end

    def generate_random_fields
      @avro_schema.fields.inject(Hash.new) do |hash, field|
        type_gen = TypeGenerator.new(field)
        hash[field.name] = type_gen.generate_value
        hash
      end
    end

    def encode(fields)
      stream = StringIO.new
      writer = Avro::IO::DatumWriter.new(@avro_schema)
      encoder = Avro::IO::BinaryEncoder.new(stream)

      # Always start with the magic byte.
      encoder.write(MAGIC_BYTE)

      # The schema id is encoded as a 4-byte big-endian integer.
      fullname = Avro::Name.make_fullname(@schema_name, @namespace)
      #encoder.write([fullname].pack("N"))
      encoder.write([1].pack("N"))

      # The actual message comes last.
      writer.write(fields, encoder)

      stream.string
    end

    def with_timing
      while true
        yield
        if(@messages_per_second)
          sleep (1 / @messages_per_second)
        end
      end
    end

    def canonical_schema_file_name
      File.join(File.dirname(__FILE__), '..', '..', @schema_file_name)
    end

    class TypeGenerator
      def initialize(field)
        @field = field
      end


      def generate_value(type = @field.type)
        case type.type_sym
        when :null;    nil
        when :boolean; generate_boolean
        when :string;  generate_string
        when :int;     generate_int
        when :long;    generate_long
        when :float;   generate_float
        when :double;  generate_double
        when :bytes;   generate_bytes
        when :fixed;   generate_fixed
        when :enum;    generate_enum
        when :array;   generate_array
        when :map;     generate_map
        when :union;   generate_union(@field)
        #when :record, :error, :request;
        else
          raise Avro::AvroError.new("Unknown type: #{writers_schema.type}")
        end
      end

      def generate_long; generate_int; end

      def generate_int
        (0..100).to_a.sample
      end

      def generate_string
        letters = ('a'..'z').to_a
        generate_int.times.map{ letters.sample }.join
      end

      def generate_union(field)
        selected_type = field.type.schemas.sample
        generate_value(selected_type)
      end
    end

  end
end
