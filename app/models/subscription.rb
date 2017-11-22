class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  def make_stripe_payment(stripe_customer)
    update!(
      payment_method: :stripe, status: :pending_initial_payment,
      remote_id: stripe_customer.find_subscription_for(plan)
    )
  end
end
