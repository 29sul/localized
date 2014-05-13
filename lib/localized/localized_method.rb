module Localized
  class LocalizedMethod
    def initialize(method_name, type)
      @method_name = method_name
      @type = type
    end

    def read(target)
      parser.localize target.send(@method_name)
    end

    def write(target, value)
      target.send :"#{@method_name}=", parser.parse(value)
    end

    def parser
      @parser ||= detect_parser
    end

    private

    def detect_parser
      case @type
      when :integer
        I18n::IntegerParser
      when :float, :decimal
        I18n::NumericParser
      when :date
        I18n::DateParser
      when :datetime, :timestamp, :time
        I18n::TimeParser
      when :float_time
        I18n::FloatTimeParser
      when ::Module
        @type
      else
        raise RuntimeError, "Parser not detected from type #{@type}."
      end
    end
  end
end
