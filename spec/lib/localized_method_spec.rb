require 'spec_helper'
require 'custom_parsers/foo_parser'
require 'models/person'

describe Localized::LocalizedMethod do
  before do
    I18n.locale = :'pt-BR'

    @person = Person.new
    @person_localized = Localized::LocalizedMethod.new :age, :date
  end

  describe '#read' do
    it { @person_localized.read(@person).should eq '22/01/1988' }
  end

  describe '#write' do
    before { @person_localized.write @person, '26/03/1981' }

    it { @person.age.should eq Date.new(1981, 3, 26) }
  end

  describe 'detect parser' do
    context ':integer' do
      subject { Localized::LocalizedMethod.new :foo, :integer }

      it { subject.parser.should eq I18n::IntegerParser }
    end

    context ':date' do
      subject { Localized::LocalizedMethod.new :foo, :date }

      it { subject.parser.should eq I18n::DateParser }
    end

    context ':datetime' do
      subject { Localized::LocalizedMethod.new :foo, :datetime }

      it { subject.parser.should eq I18n::TimeParser }
    end

    context ':timestamp' do
      subject { Localized::LocalizedMethod.new :foo, :timestamp }

      it { subject.parser.should eq I18n::TimeParser }
    end

    context ':time' do
      subject { Localized::LocalizedMethod.new :foo, :time }

      it { subject.parser.should eq I18n::TimeParser }
    end

    context ':float_time' do
      subject { Localized::LocalizedMethod.new :foo, :float_time }

      it { subject.parser.should eq I18n::FloatTimeParser }
    end

    context '::Module' do
      subject { Localized::LocalizedMethod.new :foo, FooParser }

      it { subject.parser.should eq FooParser }
    end

    context ':other_parser' do
      subject { Localized::LocalizedMethod.new :foo, :other_parser }

      it { lambda { subject.parser }.should raise_error(RuntimeError, "Parser not detected from type other_parser.") }
    end
  end
end
