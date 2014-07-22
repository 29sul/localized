require 'spec_helper'

describe Localized::Parser::DateParser do
  context 'en locale' do
    before { I18n.locale = :en }

    describe '#parse' do
      it { expect(subject.parse('2014-04-13')).to eq Date.new(2014, 4, 13) }

      it { expect(subject.parse('2014-04-31')).to eq nil }

      it { expect(subject.parse('2014/07/17')).to eq Date.new(2014, 7, 17) }

      it { expect(subject.parse('10/09/25')).to eq Date.new(2010, 9, 25) }

      it { expect(subject.parse('11-3-5')).to eq Date.new(2011, 3, 5) }

      it { expect(subject.parse('10/1')).to eq Date.new(Date.today.year, 10, 1) }

      it { expect(subject.parse('8-27')).to eq Date.new(Date.today.year, 8, 27) }

      it { expect(subject.parse('20146-04-13')).to eq nil }

      it { expect(subject.parse('20120/04/20')).to eq nil }
    end

    describe '#localize' do
      it { expect(subject.localize(Date.new(2010, 10, 25))).to eq '2010-10-25' }
    end
  end

  context 'pt-BR locale' do
    before { I18n.locale = :'pt-BR' }

    describe '#parse' do
      it { expect(subject.parse('22/01/2014')).to eq Date.new(2014, 1, 22) }

      it { expect(subject.parse('31/02/2014')).to eq nil }

      it { expect(subject.parse('17-07-2014')).to eq Date.new(2014, 7, 17) }

      it { expect(subject.parse('25/09/10')).to eq Date.new(2010, 9, 25) }

      it { expect(subject.parse('5-3-11')).to eq Date.new(2011, 3, 5) }

      it { expect(subject.parse('1/10')).to eq Date.new(Date.today.year, 10, 1) }

      it { expect(subject.parse('27-8')).to eq Date.new(Date.today.year, 8, 27) }

      it { expect(subject.parse('22/01/20146')).to eq nil }

      it { expect(subject.parse('17-07-20107')).to eq nil }
    end

    describe '#localize' do
      it { expect(subject.localize(Date.new(2014, 2, 14))).to eq '14/02/2014' }
    end
  end
end
