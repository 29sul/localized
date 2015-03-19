module Localized
  module Parser
    module DateParser
      extend self

      def parse(value)
        return value unless valid_for_parsing? value

        parsed_value = parse_value value

        build_object parsed_value if parsed_value
      end

      def localize(value)
        valid_for_localization?(value) ? I18n.localize(value, format: i18n_localize_format) : value
      end

      protected

      def build_object(parsed_value)
        begin
          Date.new *extract_date(parsed_value)
        rescue
          nil
        end
      end

      def parse_value(value)
        i18n_formats.collect { |f| Date._strptime(value, f) }.compact.first
      end

      def adjust_parsed_value(parsed_value)
        today = Time.now

        parsed_value.reverse_merge! year: today.year, mon: today.mon, mday: today.mday, hour: 0, min: 0, sec: 0
        parsed_value[:year] = adjust_year_value parsed_value[:year]
        parsed_value
      end

      def adjust_year_value(year)
        if year > 9999
          nil
        elsif year > 99
          year
        elsif year > 30
          century - 100 + year
        else
          century + year
        end
      end

      def extract_date(parsed_date)
        adjust_parsed_value(parsed_date).values_at(:year, :mon, :mday)
      end

      def century
        current_year = Date.today.year

        current_year - (current_year % 100)
      end

      def i18n_default_format
        I18n.t :default, scope: [ i18n_scope, :formats ]
      end

      def i18n_localized_formats
        I18n.t :localized, scope: [ i18n_scope, :formats ], default: [ [] ]
      end

      def i18n_formats
        formats = [ i18n_default_format ]
        formats.concat i18n_localized_formats
        formats.compact
      end

      def i18n_scope
        :date
      end

      def i18n_localize_format
        :default
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
