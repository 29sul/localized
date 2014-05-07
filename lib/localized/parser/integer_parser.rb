module Localized
  module Parser
    module IntegerParser
      include NumericParser
      extend self

      private
      def precision
        0
      end

      def valid_for_localization?(value)
        value.is_a? Integer
      end
    end
  end
end
