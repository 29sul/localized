require 'support/active_record'

class Product < ActiveRecord::Base
  localized methods: { amount: :decimal }

  def amount
    quantity * unit_amount
  end
end
