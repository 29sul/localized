require 'spec_helper'

describe Localized::Parser::NumericParser do
  context 'en locale' do
    before { I18n.locale = :en }

    describe '#parse' do
      it { expect(subject.parse('1,245.350')).to eq 1_245.35 }

      it { expect(subject.parse('110.250')).to eq 110.25 }

      it { expect(subject.parse('35')).to eq 35 }
    end

    describe '#localize' do
      it { expect(subject.localize(1_245.35)).to eq '1,245.350' }

      it { expect(subject.localize(110.25)).to eq '110.250' }

      it { expect(subject.localize(35)).to eq '35' }
    end
  end

  context 'pt-BR locale' do
    before { I18n.locale = :'pt-BR' }

    describe '#parse' do
      it { expect(subject.parse('1.245,35')).to eq 1_245.35 }

      it { expect(subject.parse('110,25')).to eq 110.25 }

      it { expect(subject.parse('35')).to eq 35 }
    end

    describe '#localize' do
      it { expect(subject.localize(1_245.35)).to eq '1.245,35' }

      it { expect(subject.localize(110.25)).to eq '110,25' }

      it { expect(subject.localize(35)).to eq '35' }
    end
  end
end
