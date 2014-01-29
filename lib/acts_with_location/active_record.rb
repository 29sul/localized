module ActsWithLocation
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_with_location(options = {})
        options.reverse_merge! methods: {}

        mattr_accessor :localized_methods
        self.localized_methods = {}

        columns.each do |column|
          if [ :date, :time, :datetime, :timestamp, :float, :decimal ].include? column.type
            options[:methods][column.name] ||= column.type
          end
        end

        options[:methods].each do |method_name, type|
          self.localized_methods[method_name] = LocalizedMethod.new method_name, type
        end

        options[:methods].each do |method_name, type|
          define_method :"#{method_name}_localized" do
            self.class.localized_methods[method_name].read self
          end

          define_method :"#{method_name}_localized=" do |value|
            self.class.localized_methods[method_name].write self, value
          end
        end
      end
    end
  end
end
