require 'spec_helper'

describe Localized::Parser::TimeParser do
  context 'en locale' do
    before { I18n.locale = :en }

    describe '#parse' do
      it { subject.parse('Fri, 3 Oct 2014 12:01:00 -0200').should eq time_object(year: 2014, month: 10, day: 3, hour: 12, min: 1, sec: 0) }

      it { subject.parse('Fri, 22 Jan 1988 20:54:00 -0200').should eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54, sec: 0) }

      it { subject.parse('Fri, 22 Jan 1988 20:54:00').should eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54, sec: 0) }

      it { subject.parse('Fri, 22 Jan 1988 20:54').should eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54) }

      it { subject.parse('20:54:00').should eq time_object(hour: 20, min: 54, sec: 0) }

      it { subject.parse('20:54').should eq time_object(hour: 20, min: 54) }
    end

    describe '#localize' do
      it { subject.localize(Time.new(2010, 10, 25, 1, 33)).should eq 'Mon, 25 Oct 2010 01:33:00 -0200' }
    end
  end

  context 'pt-BR locale' do
    before { I18n.locale = :'pt-BR' }

    describe '#parse' do
      it { subject.parse('7/11/2014 9:35').should eq time_object(year: 2014, month: 11, day: 7, hour: 9, min: 35) }

      it { subject.parse('31/02/2014 8:00').should eq time_object(year: 2014, month: 2, day: 31, hour: 8, min: 0) }

      it { subject.parse('15-7-1997 23:00').should eq time_object(year: 1997, month: 7, day: 15, hour: 23, min: 0) }

      it { subject.parse('23:00:10').should eq time_object(hour: 23, min: 0, sec: 10) }

      it { subject.parse('23:00').should eq time_object(hour: 23, min: 00) }
    end

    describe '#localize' do
      it { subject.localize(Time.new(2014, 2, 14, 17, 55)).should eq '14/02/2014 17:55' }
    end
  end
end

def time_object(year: Date.today.year, month: Date.today.mon, day: Date.today.mday, hour: Time.now.hour, min: Time.now.min, sec: Time.now.sec)
  Time.utc year, month, day, hour, min, sec
end
