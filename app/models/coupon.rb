class Coupon < ApplicationRecord
  # validates_presence_of :name, :code, :discount_type, :discount_amount, :merchant_id, :active
  validates :name, presence: true
  validates :code, presence: true
  validates :discount_type, presence: true
  validates :discount_amount, presence: true
  validates :merchant_id, presence: true
  validates :active, inclusion: [true, false]
  validates :active, exclusion: [nil]
  
  validates :code, uniqueness: true
  belongs_to :merchant
  has_many :invoices

  enum discount_type: { percent: 0, dollar: 1 }

  def use_count
    invoices.joins(:transactions).where("transactions.result = 1").count
  end

end