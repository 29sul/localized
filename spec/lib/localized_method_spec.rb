require 'spec_helper'
require 'support/foo_parser'
require 'models/person'

describe Localized::LocalizedMethod do
  before do
    I18n.locale = :'pt-BR'

    @person = Person.new
    @person_localized = Localized::LocalizedMethod.new :age, :date
  end

  describe '#read' do
    it { expect(@person_localized.read(@person)).to eq '22/01/1988' }
  end

  describe '#write' do
    before { @person_localized.write @person, '26/03/1981' }

    it { expect(@person.age).to eq Date.new(1981, 3, 26) }
  end

  describe 'detect parser' do
    context ':integer' do
      subject { Localized::LocalizedMethod.new :column_name, :integer }

      it { expect(subject.parser).to eq I18n::IntegerParser }
    end

    context ':date' do
      subject { Localized::LocalizedMethod.new :column_name, :date }

      it { expect(subject.parser).to eq I18n::DateParser }
    end

    context ':datetime' do
      subject { Localized::LocalizedMethod.new :column_name, :datetime }

      it { expect(subject.parser).to eq I18n::TimeParser }
    end

    context ':timestamp' do
      subject { Localized::LocalizedMethod.new :column_name, :timestamp }

      it { expect(subject.parser).to eq I18n::TimeParser }
    end

    context ':time' do
      subject { Localized::LocalizedMethod.new :column_name, :time }

      it { expect(subject.parser).to eq I18n::TimeParser }
    end

    context ':float_time' do
      subject { Localized::LocalizedMethod.new :column_name, :float_time }

      it { expect(subject.parser).to eq I18n::FloatTimeParser }
    end

    context '::Module' do
      subject { Localized::LocalizedMethod.new :column_name, FooParser }

      it { expect(subject.parser).to eq FooParser }
    end

    context ':other_parser' do
      subject { Localized::LocalizedMethod.new :column_name, :other_parser }

      it { expect(lambda { subject.parser }).to raise_error(RuntimeError, "Parser not detected from type other_parser.") }
    end
  end
end
