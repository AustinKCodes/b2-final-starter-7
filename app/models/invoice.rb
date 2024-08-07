class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def merchant_subtotal(merchant)
    invoice_items.joins(:item)
                  .where(items: { merchant_id: merchant.id })
                  .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def merchant_grand_total(merchant, coupon)
    subtotal = merchant_subtotal(merchant)
    discount = 0
    if coupon
      if coupon.discount_type == "percent"
        discount = (subtotal * coupon.discount_amount / 100)
      elsif coupon.discount_type == "dollar"
        discount = [coupon.discount_amount, subtotal].min      
      end
      subtotal - discount
    else
      subtotal
    end
  end

  def subtotal
    invoice_items.joins(:item).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def grandtotal(coupon)
    subtotal = invoice_items.joins(:item).sum("invoice_items.unit_price * invoice_items.quantity")
    discount = 0
    if coupon
      if coupon.discount_type == "percent"
        discount = (subtotal * coupon.discount_amount / 100)
      elsif coupon.discount_type == "dollar"
        discount = [coupon.discount_amount, subtotal].min      
      end
      puts subtotal
      subtotal - discount
    end
  end
end
