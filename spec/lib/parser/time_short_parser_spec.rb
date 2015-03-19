require 'spec_helper'

describe Localized::Parser::TimeShortParser do
  context 'en locale' do
    before do
      I18n.locale = :en
      Time.zone = 'UTC'
    end

    describe '#parse' do
      it { expect(subject.parse('Fri, 3 Oct 2014 12:01:00 -0200')).to eq time_object(year: 2014, month: 10, day: 3, hour: 12, min: 1, sec: 0) }

      it { expect(subject.parse('Fri, 22 Jan 1988 20:54:00 -0200')).to eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54, sec: 0) }

      it { expect(subject.parse('Fri, 22 Jan 1988 20:54:00')).to eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54, sec: 0) }

      it { expect(subject.parse('Fri, 22 Jan 1988 20:54')).to eq time_object(year: 1988, month: 1, day: 22, hour: 20, min: 54) }

      it { expect(subject.parse('20:54:00')).to eq time_object(hour: 20, min: 54, sec: 0) }

      it { expect(subject.parse('20:54')).to eq time_object(hour: 20, min: 54) }

      it { expect(subject.parse('Fri, 3 Oct 20148 12:01:00 -0200')).to eq nil }
    end

    describe '#localize' do
      it { expect(subject.localize(Time.utc(2010, 10, 25, 1, 33))).to eq '01:33' }
    end
  end

  context 'pt-BR locale' do
    before do
      I18n.locale = :'pt-BR'
      Time.zone = 'America/Sao_Paulo'
    end

    describe '#parse' do
      it { expect(subject.parse('7/11/2014 9:35')).to eq time_object(year: 2014, month: 11, day: 7, hour: 9, min: 35) }

      it { expect(subject.parse('31/02/2014 8:00')).to eq time_object(year: 2014, month: 2, day: 31, hour: 8, min: 0) }

      it { expect(subject.parse('15-7-1997 23:00')).to eq time_object(year: 1997, month: 7, day: 15, hour: 23, min: 0) }

      it { expect(subject.parse('23:00:10')).to eq time_object(hour: 23, min: 0, sec: 10) }

      it { expect(subject.parse('23:00')).to eq time_object(hour: 23, min: 00) }

      it { expect(subject.parse('7/11/20148 9:35')).to eq nil }

      it { expect(subject.parse('15-7-19971 23:00')).to eq nil }
    end

    describe '#localize' do
      it { expect(subject.localize(Time.new(2014, 2, 14, 17, 55))).to eq '17:55' }
    end
  end
end
