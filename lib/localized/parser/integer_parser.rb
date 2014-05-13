module Localized
  module Parser
    module IntegerParser
      include NumericParser
      extend self

      private
      def build_object(value)
        value.gsub(delimiter, '_').gsub(separator, '.').to_i
      end

      def precision
        0
      end

      def valid_for_localization?(value)
        value.is_a? Numeric
      end
    end
  end
end
