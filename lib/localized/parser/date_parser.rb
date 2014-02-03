module Localized
  module Parser
    module DateParser
      extend self

      def parse(value)
        return value unless valid_for_parsing? value

        parsed_value = Date._strptime value, i18n_format

        if parsed_value
          build_object parsed_value
        end
      end

      def localize(value)
        valid_for_localization?(value) ? I18n.localize(value) : value
      end

      protected

      def build_object(parsed_value)
        Date.new *extract_date(parsed_value)
      end

      def extract_date(parsed_date)
        parsed_date.values_at(:year, :mon, :mday).compact
      end

      def i18n_format
        I18n.t :default, scope: [ i18n_scope, :formats ]
      end

      def i18n_scope
        :date
      end

      def valid_for_localization?(value)
        value.is_a? Date
      end

      def valid_for_parsing?(value)
        !(valid_for_localization? value or value.nil?)
      end
    end
  end
end
