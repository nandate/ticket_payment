class PreparesCart

  attr_accessor :user, :purchase_amount_cents,
      :purchase_amount, :success,
      :payment, :expected_ticket_ids,
      :payment_reference

  def initialize(user: nil, purchase_amount_cents: nil,
      expected_ticket_ids: "", payment_reference: nil)
    @user = user
    @purchase_amount = Money.new(purchase_amount_cents)
    @success =false
    @continue = true
    @expected_ticket_ids = expected_ticket_ids.split(" ").map(&:to_i).sort
    @payment_reference = payment_reference || Payment.generate_reference
  end

  def pre_purchase_valid?
    purchase_amount == tickets.map(&:price).sum &&
        expected_ticket_ids == tickets.map(&:id).sort
  end

  def tickets
    @tickets ||= @user.tickets_in_cart.select do |ticket|
      ticket.payment_reference == payment_reference
    end
  end

  def existing_payment
    Payment.find_by(reference: payment_reference)
  end

  def run
    Payment.transaction do
      return if existing_payment
      return unless pre_purchase_valid?
      update_tickets
      create_payment
      success? ? on_success : on_failure
    end
  end

  def redirect_on_success_url
    nil
  end

  def create_payment
    self.payment = existing_payment || Payment.new
    payment.update!(payment_attributes)
    payment.create_line_items(tickets)
    @success = payment.valid?
  end

  def payment_attributes
    {user_id: user_id, price_cents: purchase_amount_cents,
     status: "created", reference: Payment.generate_reference}
   end

   def success?
     success
   end

   def unpurchase_tickets
     tickets.each(&:waiting!)
   end
   
end
