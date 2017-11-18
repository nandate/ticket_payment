class PaymentLineItem < ApplicationRecord
  belongs_to :payment
  belongs_to :buyable
end
