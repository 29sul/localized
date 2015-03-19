module Localized
  module Parser
    module TimeParser
      include DateParser
      extend  self

      def parse(value)
        return value unless valid_for_parsing? value

        parsed_value = parse_value value

        if parsed_value
          build_object parsed_value
        else
          date = DateParser.parse(value)

          Time.zone.local date.year, date.month, date.day unless date.nil?
        end
      end

      protected

      def build_object(parsed_value)
        begin
          Time.zone.local *extract_datetime(parsed_value)
        rescue
          nil
        end
      end

      def extract_datetime(parsed_value)
        adjust_parsed_value(parsed_value).values_at(:year, :mon, :mday, :hour, :min, :sec)
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
