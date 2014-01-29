module ActsWithLocation
  module Parser
    module TimeParser
      include DateParser
      extend  self

      protected

      def build_object(parsed_value)
        Time.zone.local *extract_datetime(parsed_value)
      end

      def extract_datetime(parsed_value)
        parsed_value.values_at(:year, :mon, :mday, :hour, :min, :sec).compact
      end

      def i18n_scope
        :time
      end

      def valid_for_localization?(value)
        value.is_a?(Time) || value.is_a?(DateTime)
      end
    end
  end
end
