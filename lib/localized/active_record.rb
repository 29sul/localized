module Localized
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def localized(options = {})
        options.reverse_merge! methods: {}

        mattr_accessor :localized_methods
        self.localized_methods = options[:methods]

        columns_to_localize

        build_localized_parsers

        build_localized_methods
      end

      private
      def locate?(type)
        [ :date, :time, :datetime, :timestamp, :float, :decimal ].include? type
      end

      def columns_to_localize
        columns.each do |column|
          add_column_to_localized_methods column if locate?(column.type)
        end
      end

      def add_column_to_localized_methods(column)
        self.localized_methods[column.name.to_sym] ||= column.type
      end

      def build_localized_parsers
        localized_methods.each do |method_name, type|
          self.localized_methods[method_name] = LocalizedMethod.new method_name, type
        end
      end

      def build_localized_methods
        localized_methods.each do |method_name, parser_type|
          build_localized_method_read method_name
          build_localized_method_write method_name
        end
      end

      def build_localized_method_read(method_name)
        define_method :"#{method_name}_localized" do
          self.class.localized_methods[method_name].read self
        end
      end

      def build_localized_method_write(method_name)
        define_method :"#{method_name}_localized=" do |value|
          self.class.localized_methods[method_name].write self, value
        end
      end
    end
  end
end
