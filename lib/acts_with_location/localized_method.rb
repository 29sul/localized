module ActsWithLocation
  class LocalizedMethod
    def initialize(method_name, type)
      @method_name = method_name
      @type = type
    end

    def read(target)
      detect_parser.localize target.send(@method_name)
    end

    def write(target, value)
      target.send :"#{@method_name}=", detect_parser.parse(value)
    end

    private

    def detect_parser
      case @type
      when :float, :decimal
        I18n::NumericParser
      when :date
        I18n::DateParser
      when :datetime, :timestamp, :time
        I18n::TimeParser
      when ::Module
        @type
      end
    end
  end
end
