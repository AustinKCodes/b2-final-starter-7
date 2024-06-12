require "rails_helper"

RSpec.describe "Merchant Bulk Discount Index Page" do
    before :each do
        @merchant = Merchant.create!(name: "Merchant A")
        @disount1 = @merchant.bulk_discounts.create!(percentage_discount: 20, bulk_amount_threshold: 10)
        @discount2 = @merchant.bulk_discounts.create!(percent_discount: 30, bulk_amount_threshold: 15)
    end

    it "should show a link to see all discounts" do
        visit merchant_dashboard_path(@merchant)

        expect(page).to have_link("See All Discounts")

        click_link("See All Discounts")

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
        expect(page).to have_content("20% off 10 items")
        expect(page).to have_content("30% off 15 items")

        within("#discount-#{@discount1.id}") do
            expect(page).to have_link(@discount1.percentage_discount)
        end

        within("#discount-#{@discount2.id}") do
            expect(page).to have_link(@discount2.percentage_discount)
        end
    end
end