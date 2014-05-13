require 'spec_helper'

describe Localized::Parser::IntegerParser do
  context 'en locale' do
    before { I18n.locale = :en }

    describe '#parse' do
      it { subject.parse('1,245.350').should eq 1_245 }

      it { subject.parse('110.250').should eq 110 }

      it { subject.parse('35').should eq 35 }
    end

    describe '#localize' do
      it { subject.localize(1_245.35).should eq '1,245' }

      it { subject.localize(110.25).should eq '110' }

      it { subject.localize(35).should eq '35' }
    end
  end

  context 'pt-BR locale' do
    before { I18n.locale = :'pt-BR' }

    describe '#parse' do
      it { subject.parse('1.245,35').should eq 1_245 }

      it { subject.parse('110,25').should eq 110 }

      it { subject.parse('35').should eq 35 }
    end

    describe '#localize' do
      it { subject.localize(1_245.35).should eq '1.245' }

      it { subject.localize(110.25).should eq '110' }

      it { subject.localize(35).should eq '35' }
    end
  end
end
