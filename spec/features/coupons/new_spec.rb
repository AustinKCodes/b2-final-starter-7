require "rails_helper"

describe "Coupon New page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
  end

  it "should bring up a form and be able to create a new coupon" do
    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "Coupon 5"
    fill_in "Code", with: "10OFF"
    select "percent", from: "Discount Type"
    fill_in "Discount Amount:", with: "10"
    click_button "Create"

    expect(current_path).to eq(merchant_coupons_path(@merchant1))

    expect(page).to have_content("Coupon 5")
    expect(page).to have_content("10% off")
  end

  it "shouldn't create a coupon with a non-unique code" do
    @merchant1.coupons.create!(name: "EXCode", code: "EXCODE", discount_type: 0, discount_amount: 10, active: true)
    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "EXCode"
    fill_in "Code", with: "EXCODE"
    select "percent", from: "Discount Type"
    fill_in "Discount Amount", with: "10"
    check "Active"
    click_button "Create"

    expect(page).to have_content("Code has already been taken")
  end

  it "shouldn't create a coupon if merchant has 5 coupons active" do
    5.times do |i|
      @merchant1.coupons.create!(name: "Coupon #{i}", code: "CODE#{i}", discount_type: 0, discount_amount: 10, active:true)
    end
    visit new_merchant_coupon_path(@merchant1)

    fill_in "Name", with: "EXCode"
    fill_in "Code", with: "EXCODE"
    select "percent", from: "Discount Type"
    fill_in "Discount Amount", with: "10"
    check "Active"
    click_button "Create"

    expect(page).to have_content("Merchant has 5 Active Coupons already selected")
  end
end