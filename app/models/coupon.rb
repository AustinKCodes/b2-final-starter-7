class Coupon < ApplicationRecord
  belongs_to :merchant

  enum discount_type: { percent: 0, dollar: 1 }

end