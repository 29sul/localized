require 'spec_helper'

describe Localized::Parser::DateParser do
  context 'en locale' do
    before { I18n.locale = :en }

    describe '#parse' do
      it { subject.parse('2014-04-13').should eq Date.new(2014, 4, 13) }

      it { subject.parse('2014-04-31').should eq nil }

      it { subject.parse('2014/07/17').should eq Date.new(2014, 7, 17) }

      it { subject.parse('10/09/25').should eq Date.new(2010, 9, 25) }

      it { subject.parse('11-3-5').should eq Date.new(2011, 3, 5) }

      it { subject.parse('10/1').should eq Date.new(Date.today.year, 10, 1) }

      it { subject.parse('8-27').should eq Date.new(Date.today.year, 8, 27) }

      it { subject.parse('20146-04-13').should eq nil }

      it { subject.parse('20120/04/20').should eq nil }
    end

    describe '#localize' do
      it { subject.localize(Date.new(2010, 10, 25)).should eq '2010-10-25' }
    end
  end

  context 'pt-BR locale' do
    before { I18n.locale = :'pt-BR' }

    describe '#parse' do
      it { subject.parse('22/01/2014').should eq Date.new(2014, 1, 22) }

      it { subject.parse('31/02/2014').should eq nil }

      it { subject.parse('17-07-2014').should eq Date.new(2014, 7, 17) }

      it { subject.parse('25/09/10').should eq Date.new(2010, 9, 25) }

      it { subject.parse('5-3-11').should eq Date.new(2011, 3, 5) }

      it { subject.parse('1/10').should eq Date.new(Date.today.year, 10, 1) }

      it { subject.parse('27-8').should eq Date.new(Date.today.year, 8, 27) }

      it { subject.parse('22/01/20146').should eq nil }

      it { subject.parse('17-07-20107').should eq nil }
    end

    describe '#localize' do
      it { subject.localize(Date.new(2014, 2, 14)).should eq '14/02/2014' }
    end
  end
end
