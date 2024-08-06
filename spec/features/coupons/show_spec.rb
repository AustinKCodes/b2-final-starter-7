require "rails_helper"

RSpec.describe "Coupon Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @coupon1 = @merchant1.coupons.create!(name: "Coupon 1", code: "CODE1", discount_type: 0, discount_amount: 10, active:true)
    @coupon2 = @merchant1.coupons.create!(name: "Coupon 2", code: "CODE2", discount_type: 0, discount_amount: 10, active:true)

    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2, coupon: @coupon1)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2, coupon: @coupon1)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1, coupon: @coupon1)
    @invoice_8 = Invoice.create!(customer_id: @customer_4.id, status: 0, coupon: @coupon1)
    @invoice_9 = Invoice.create!(customer_id: @customer_5.id, status: 0, coupon: @coupon1)
    @invoice_1 = Invoice.create!(customer_id: @customer_6.id, status: 2, coupon: @coupon1)

    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_7.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 0, invoice_id: @invoice_6.id)
    @transaction9 = Transaction.create!(credit_card_number: 102938, result: 0, invoice_id: @invoice_8.id)
    @transaction8 = Transaction.create!(credit_card_number: 102938, result: 0, invoice_id: @invoice_9.id)
    @transaction7 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_1.id)

    visit merchant_coupons_path(@merchant1)
  end

  it "shows all coupons with their details" do
    click_link "Coupon 1"

    expect(page).to have_content(@coupon1.name)
    expect(page).to have_content(@coupon1.code)
    expect(page).to have_content("10% off")
    expect(page).to have_content("Active")
    expect(page).to_not have_content(@coupon2.name)
  end

  it "should count how many coupons have been used" do
    visit merchant_coupon_path(@merchant1, @coupon1)

    expect(page).to have_content("Use Count: #{@coupon1.use_count}")
    expect(page).to_not have_content("Use Count: #{@coupon2.use_count}")
  end

end