require 'spec_helper'
require 'models/product'

describe Localized::ActiveRecord do
  before do
    @product = Product.new quantity: 7, unit_amount: 1.25, delivery_at: Date.new(2014, 7, 30),
      delivery_time: Time.new
  end

  describe 'quantity of localized methods' do
    it { @product.class.localized_methods.size.should eq 6 }
  end

  describe 'localized read methods' do
    it { @product.should respond_to :amount_localized }

    it { @product.should respond_to :unit_amount_localized }

    it { @product.should respond_to :delivery_at_localized }

    it { @product.should respond_to :delivery_time_localized }

    it { @product.should respond_to :created_at_localized }

    it { @product.should respond_to :updated_at_localized }
  end

  describe 'localized write methods' do
    it { @product.should respond_to :'amount_localized=' }

    it { @product.should respond_to :'unit_amount_localized=' }

    it { @product.should respond_to :'delivery_at_localized=' }

    it { @product.should respond_to :'delivery_time_localized=' }

    it { @product.should respond_to :'created_at_localized=' }

    it { @product.should respond_to :'updated_at_localized=' }
  end

  describe 'assign value' do
    before do
      I18n.locale = :'pt-BR'

      @product.unit_amount_localized = '1.232,10'
      @product.delivery_at_localized = '11/10/2014'
    end

    it { @product.unit_amount.should eq 1_232.10 }

    it { @product.delivery_at.should eq Date.new(2014, 10, 11) }

    it { @product.amount.to_f.should eq 8_624.7 }
  end
end
