class Coupon < ApplicationRecord
  belongs_to :merchant

  enum discount_type: { percent: 0, dollar: 1 }

  private

  def value_must_be_positive
    errors.add(:value, "must be greater than 0") if value <= 0
  end
end