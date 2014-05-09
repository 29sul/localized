require "i18n"
require "active_record"
require "localized/version"

module Localized
  module Parser
    autoload :DateParser      , "localized/parser/date_parser"
    autoload :FloatTimeParser , "localized/parser/float_time_parser"
    autoload :IntegerParser   , "localized/parser/integer_parser"
    autoload :NumericParser   , "localized/parser/numeric_parser"
    autoload :TimeParser      , "localized/parser/time_parser"
  end

  autoload :ActiveRecord   , "localized/active_record"
  autoload :LocalizedMethod, "localized/localized_method"
end

I18n.send :include, Localized::Parser

ActiveRecord::Base.send :include, Localized::ActiveRecord
