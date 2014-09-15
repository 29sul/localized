module Localized
  module Parser
    module TimeShortParser
      include TimeParser
      extend  self

      protected

      def i18n_localize_format
        :short
      end
    end
  end
end
