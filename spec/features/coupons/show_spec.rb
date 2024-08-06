require "rails_helper"

RSpec.describe "Coupon Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @coupon1 = @merchant1.coupons.create!(name: "Coupon 1", code: "CODE1", discount_type: 0, discount_amount: 10, active:true)

    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    

    visit merchant_coupons_path(@merchant1)
  end

  it "shows all coupons with their details" do
    click_link "Coupon 1"

    expect(page).to have_content(@coupon1.name)
    expect(page).to have_content(@coupon1.code)
    expect(page).to have_content("10% off")
    expect(page).to have_content("Active")
  end

  it "should count how many coupons have been used" do

  end

end