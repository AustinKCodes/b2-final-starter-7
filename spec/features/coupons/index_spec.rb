require "rails_helper"

RSpec.describe "Merchant Coupons Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Poseidon's Pools")

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    @coupon1 = Coupon.create!(name: "Coupon 1", code: "BOGO50", discount_type: 0, discount_amount: 50, merchant: @merchant1, active: true)
    @coupon2 = Coupon.create!(name: "Coupon 2", code: "SAVE10", discount_type: 1, discount_amount: 10, merchant: @merchant1, active: true)
    @coupon3 = Coupon.create!(name: "Coupon 3", code: "SAVE20", discount_type: 0, discount_amount: 20, merchant: @merchant1, active: false)
    @coupon4 = Coupon.create!(name: "Coupon 4", code: "POOL20", discount_type: 0, discount_amount: 30, merchant: @merchant2, active: true)
    

    visit merchant_dashboard_index_path(@merchant1)
  end

  it "should show a link to view all coupons" do
    expect(page).to have_link("View All Coupons")
  end

  it "should take me to the coupons index page" do
    click_link "View All Coupons"
    expect(current_path).to eq(merchant_coupons_path(@merchant1))

    expect(page).to have_content(@coupon1.name)
    expect(page).to have_content("50% off")
    expect(page).to have_content(@coupon2.name)
    expect(page).to have_content("$10 off")
    expect(page).to have_content(@coupon3.name)
    expect(page).to have_content("20% off")
    expect(page).to_not have_content(@coupon4.name)
    expect(page).to_not have_content("30% off")
  end

  it "should show the coupons and their names be links" do
    click_link "View All Coupons"
    expect(page).to have_link(@coupon1.name)
    expect(page).to have_link(@coupon2.name)
    expect(page).to have_link(@coupon3.name)
    expect(page).to_not have_link(@coupon4.name)
  end

  it " should have a create new coupon link" do
    click_link "View All Coupons"
    
    click_link "Create New Coupon"

    expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
  end
end