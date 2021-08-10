require 'rails_helper'

RSpec.describe 'Merchant shows index page' do
  describe "show" do

    before(:each) do
      @merchant_1 = create(:merchant)
      @discount = create(:discount, merchant_id: @merchant_1.id)
    end

    it "shows all attributes for discount" do
      visit "/merchants/#{@merchant_1.id}/discounts/#{@discount.id}"

      expect(page).to have_content("#{@discount.threshold}")
      expect(page).to have_content("#{@discount.percentage}")
    end

    it "has a link to edit the discount" do
      visit "/merchants/#{@merchant_1.id}/discounts/#{@discount.id}"

      click_link "Edit this discount"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discount.id}/edit")
    end

    it "has pre-populated attributes" do
      visit "/merchants/#{@merchant_1.id}/discounts/#{@discount.id}"

      click_link "Edit this discount"

      expect(find_field(:percentage).value).to eq("#{@discount.percentage}")
      expect(find_field(:threshold).value).to eq("#{@discount.threshold}")
    end

    it "can fully edit a the discounts attributes" do
      visit "/merchants/#{@merchant_1.id}/discounts/#{@discount.id}"

      click_link "Edit this discount"

      fill_in :percentage, with: 75.0
      fill_in :threshold, with: 100

      click_button "Update Discount"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discount.id}")
      expect(page).to have_content("75.0")
      expect(page).to have_content("100")
    end
  end
end
