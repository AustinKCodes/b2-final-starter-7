require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end
  end

    it "merchant_subtotal" do
      @merchant = Merchant.create!(name: "Hair Care")
      @coupon1 = @merchant.coupons.create!(name: "Coupon 1", code: "CODE1", discount_type: 0, discount_amount: 10, active: true)
      @customer = Customer.create!(first_name: "Cecilia", last_name: "Jay")
      @invoice = Invoice.create!(customer_id: @customer.id, status: 2, coupon: @coupon1)
      @item = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 10, merchant_id: @merchant.id)
      @ii = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item.id, quantity: 2, unit_price: 10, status: 2)

      expect(@invoice.merchant_subtotal(@merchant)).to eq(20)
    end

    it "merchant_grand_total" do
      @merchant = Merchant.create!(name: "Hair Care")
      @coupon1 = @merchant.coupons.create!(name: "Coupon 1", code: "CODE1", discount_type: 0, discount_amount: 10, active: true)
      @customer = Customer.create!(first_name: "Cecilia", last_name: "Jay")
      @invoice = Invoice.create!(customer_id: @customer.id, status: 2, coupon: @coupon1)
      @item = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 10, merchant_id: @merchant.id)
      @ii = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item.id, quantity: 2, unit_price: 10, status: 2)

      expect(@invoice.merchant_grand_total(@merchant, @coupon1)).to eq(18)
    end

end
