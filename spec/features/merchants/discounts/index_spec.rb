require 'rails_helper'

RSpec.describe 'Merchant discounts index page' do
  describe "index" do

    before(:each) do
      @discounts = []
      @merchant_1 = create(:merchant)
      3.times do
        @discounts << create(:discount, merchant_id: @merchant_1.id)
      end
    end

    it "I see all discounts for this merchant" do
      visit "merchants/#{@merchant_1.id}/discounts"

      expect(page).to have_content(@discounts.first.percentage)
      expect(page).to have_content(@discounts.first.threshold)

      expect(page).to have_content(@discounts.second.percentage)
      expect(page).to have_content(@discounts.second.threshold)

      expect(page).to have_content(@discounts.third.percentage)
      expect(page).to have_content(@discounts.third.threshold)
    end

    it "has a link for each discount to its show page" do
      visit "merchants/#{@merchant_1.id}/discounts"

      within "#discount-#{@discounts.first.id}" do
        click_link "#{@discounts.first.percentage}% Discount"
      end

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discounts.first.id}")
    end

    it "has a link to create a new discount" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
    end

    it "can create a new discount" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      fill_in :percentage, with: 90.5
      fill_in :threshold, with: 100

      click_button "Submit"

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")

      expect(page).to have_content(90)
      expect(page).to have_content(100)
    end

    it "should flash success when creating a discount succesfully" do
      visit "merchants/#{@merchant_1.id}/discounts"

      click_link "Create Discount"

      fill_in :percentage, with: 90.5
      fill_in :threshold, with: 100

      click_button "Submit"

      expect(page).to have_content("Success: New discount has been created!")
    end

    it "can delete each discount" do
      visit "merchants/#{@merchant_1.id}/discounts"
      
      within "#discount-#{@discounts.first.id}" do
        click_link "Delete this discount"
      end
    end
  end
end
