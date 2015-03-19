require 'spec_helper'

describe Localized::Parser::FloatTimeParser do
  describe '#parse' do

    it { expect(subject.parse('2015-03-19T20:54')).to eq 20.9 }

    it { expect(subject.parse('20:54')).to eq 20.9 }

    it { expect(subject.parse('1:30')).to eq 1.5 }

    it { expect(subject.parse('01:30')).to eq 1.5 }

    it { expect(subject.parse('01:03')).to eq 1.05 }

    it { expect(subject.parse('1:3')).to eq 1.05 }

    it { expect(subject.parse('7h15')).to eq 7.25 }

    it { expect(subject.parse('07h15')).to eq 7.25 }

    it { expect(subject.parse('17h12')).to eq 17.2 }

    it { expect(subject.parse('17h6')).to eq 17.1 }

    it { expect(subject.parse('11h')).to eq 11.0 }

    it { expect(subject.parse('11 h')).to eq 11.0 }

    it { expect(subject.parse('30m')).to eq 0.5 }

    it { expect(subject.parse('24 m')).to eq 0.4 }

    it { expect(subject.parse('13.54')).to eq 13.54 }

    it { expect(subject.parse('19,20')).to eq 19.2 }

    it { expect(subject.parse('21')).to eq 21.0 }

    it { expect(subject.parse(21)).to eq 21.0 }

    it { expect(subject.parse(7.43)).to eq 7.43 }

    it { expect(subject.parse('TEXT')).to eq 0 }
  end

  describe '#localize' do
    it { expect(subject.localize(17.5)).to eq '17:30' }

    it { expect(subject.localize(5.33333)).to eq '5:20' }

    it { expect(subject.localize(5.05)).to eq '5:03' }

    it { expect(subject.localize(0)).to eq '0:00' }

    it { expect(subject.localize(1)).to eq '1:00' }
  end
end
