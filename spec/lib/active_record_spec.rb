require 'spec_helper'
require 'models/product'

describe Localized::ActiveRecord do
  before do
    @product = Product.new quantity: 7, unit_amount: 1.25, delivery_at: Date.new(2014, 7, 30),
      delivery_time: Time.new
  end

  describe 'quantity of localized methods' do
    it { expect(@product.class.localized_methods.size).to eq 6 }
  end

  describe 'localized read methods' do
    it { expect(@product).to respond_to :amount_localized }

    it { expect(@product).to respond_to :unit_amount_localized }

    it { expect(@product).to respond_to :delivery_at_localized }

    it { expect(@product).to respond_to :delivery_time_localized }

    it { expect(@product).to respond_to :created_at_localized }

    it { expect(@product).to respond_to :updated_at_localized }
  end

  describe 'localized write methods' do
    it { expect(@product).to respond_to :'amount_localized=' }

    it { expect(@product).to respond_to :'unit_amount_localized=' }

    it { expect(@product).to respond_to :'delivery_at_localized=' }

    it { expect(@product).to respond_to :'delivery_time_localized=' }

    it { expect(@product).to respond_to :'created_at_localized=' }

    it { expect(@product).to respond_to :'updated_at_localized=' }
  end

  describe 'assign value' do
    before do
      I18n.locale = :'pt-BR'

      @product.unit_amount_localized = '1.232,10'
      @product.delivery_at_localized = '11/10/2014'
    end

    it { expect(@product.unit_amount).to eq 1_232.10 }

    it { expect(@product.delivery_at).to eq Date.new(2014, 10, 11) }

    it { expect(@product.amount.to_f).to eq 8_624.7 }
  end
end
