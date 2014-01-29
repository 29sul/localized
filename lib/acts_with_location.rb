require "acts_with_location/version"

module ActsWithLocation
  module Parser
    autoload :DateParser   , "acts_with_location/parser/date_parser"
    autoload :NumericParser, "acts_with_location/parser/numeric_parser"
    autoload :TimeParser   , "acts_with_location/parser/time_parser"
  end

  autoload :ActiveRecord   , "acts_with_location/active_record"
  autoload :LocalizedMethod, "acts_with_location/localized_method"
end

I18n.send :include, ActsWithLocation::Parser

ActiveRecord::Base.send :include, ActsWithLocation::ActiveRecord
