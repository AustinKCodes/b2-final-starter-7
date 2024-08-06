require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_presence_of :discount_type }
    it { should validate_presence_of :discount_amount }
    it { should validate_presence_of :merchant_id }
    it { should validate_inclusion_of(:active).in_array([true, false]) }
    it "abduls fix" do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @coupon1 = Coupon.create!(name: "Coupon 1", code: "BOGO50", discount_type: 0, discount_amount: 50, merchant: @merchant1, active: true)
      expect(@coupon1).to validate_uniqueness_of :code
    end
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
  end
end