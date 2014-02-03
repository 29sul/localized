# TODO: Use the translation files!
module Localized
  module Parser
    module FloatTimeParser
      extend  self

      def parse(value)
        return value if valid_for_localization? value

        value = value.strftime("%T") if value.respond_to? :strftime

        if valid_for_parsing? value
          string_to_float value
        else
          0
        end
      end

      def localize(value)
        if value.to_f > 0
          float_to_string_time value.to_f
        else
          '0:00'
        end
      end

      private

      def valid_for_localization?(value)
        value.is_a? Numeric
      end

      def valid_for_parsing?(value)
        value.respond_to? :split and value.present?
      end

      def string_to_float(value)
        case value.to_s.downcase
        when /\dT\d\d:\d\d/i
          parse value.split(/T/i).last[0..4]
        when /([0-2][0-9]|[0-9])(:|h)([0-5][0-9]|[0-9])/i
          data = value.split(/(:|h)/i)
          data[0].to_i + data[2].to_i / 60.0
        when /([0-2][0-9]|[0-9])(h| h)/i
          value.split(/h/i)[0].to_f
        when /([0-5][0-9]|[0-9])(m| m)/i
          value.split(/(m)/i)[0].to_i / 60.0
        when /(([0-2][0-9]|[0-9])(.|,)([0-9][0-9]|[0-9])|([0-2][0-9]|[0-9]))/i
          value.to_s.gsub(/[,]/, '.').to_f
        else
          value.to_f
        end
      end

      def float_to_string_time(value)
        string = ''
        minutes = ((value - value.floor) * 60).round(2).to_i
        string += value.to_i.to_s + ':'
        string += if minutes == 0
          '00'
        elsif minutes < 10
          "0#{minutes}"
        else
          minutes.to_s
        end
        string
      end

    end
  end
end
