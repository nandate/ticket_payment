class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :performance
  has_one :event, through: :performance
  monetize :price_cents

  enum status: {unsold: 0, waiting: 1}
  enum access: {general: 0}

  def place_in_cart_for(user)
    update(status: :waiting, user: user)
  end

  def refund_successful
    refunded!
    new_ticket = dup
    new_ticket.unsold!
  end

end
