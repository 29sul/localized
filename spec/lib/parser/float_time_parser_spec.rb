require 'spec_helper'

describe Localized::Parser::FloatTimeParser do
  describe '#parse' do
    it { subject.parse('20:54').should eq 20.9 }

    it { subject.parse('1:30').should eq 1.5 }

    it { subject.parse('01:30').should eq 1.5 }

    it { subject.parse('01:03').should eq 1.05 }

    it { subject.parse('1:3').should eq 1.05 }

    it { subject.parse('7h15').should eq 7.25 }

    it { subject.parse('07h15').should eq 7.25 }

    it { subject.parse('17h12').should eq 17.2 }

    it { subject.parse('17h6').should eq 17.1 }

    it { subject.parse('11h').should eq 11.0 }

    it { subject.parse('11 h').should eq 11.0 }

    it { subject.parse('30m').should eq 0.5 }

    it { subject.parse('24 m').should eq 0.4 }

    it { subject.parse('13.54').should eq 13.54 }

    it { subject.parse('19,20').should eq 19.2 }

    it { subject.parse('21').should eq 21.0 }

    it { subject.parse(7.43).should eq 7.43 }
  end

  describe '#localize' do
    it { subject.localize(17.5).should eq '17:30' }

    it { subject.localize(5.33333).should eq '5:20' }

    it { subject.localize(5.05).should eq '5:03' }

    it { subject.localize(0).should eq '0:00' }
  end
end
