require "rails_helper"
require "fake_stripe"

describe "purchasing a cart", :js do
  fixtures :all

  before(:each) do
    FakeStripe.stub_stripe
  end

  after(:each) do
    WebMock.reset!
    Stripe.api_key = Rails.application.secrets.stripe_secret_key
  end

  it "can add a purchase to a cart" do
    tickets(:midsummer_bums1).place_in_cart_for(user(:buyer))
    tickets(:midsummer_bums2).place_in_cart_for(user(:buyer))
    login_as(user(:buyer), scope: :user)
    visit shopping_cart_path
    fill_in :credit_card_number, with: "4242 4242 4242 4242"
    fill_in :expiration_month, with: "12"
    fill_in :expiration_year, with: Time.current.year + 1
    fill :cvc, with: "123"
    click_on "purchase"
    expect(page).to have_selector(".purchased_ticket", count: 2)
    expect(page).to have_selector(
      "#purchased_ticket_#{tickets(:midsummer_bums1).id}")
    expect(page).to have_selector(
      "#purchased_ticket_#{tickets(:midsummer_bums2).id}")
  end
end
