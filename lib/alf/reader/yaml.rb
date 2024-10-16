module Alf
  class Reader
    #
    # Implements Alf::Reader contract for reading YAML input.
    #
    class YAML < Reader

      def self.mime_type
        "text/yaml"
      end

      def each
        return to_enum unless block_given?
        require 'yaml'
        p = ::YAML.safe_load(input_text, permitted_classes: %w[Symbol])
        p = [p] if TupleLike===p
        p.each do |t|
          yield Support.symbolize_keys(t)
        end
      end

      Alf::Reader.register(:yaml, [".yaml", ".yml"], self)
    end # class YAML
  end # class Reader
end # module Alf
