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

      expect(page).to have_content(@discounts.first.percentage * 100)
      expect(page).to have_content(@discounts.first.threshold)

      expect(page).to have_content(@discounts.second.percentage * 100)
      expect(page).to have_content(@discounts.second.threshold)

      expect(page).to have_content(@discounts.third.percentage * 100)
      expect(page).to have_content(@discounts.third.threshold)
    end

    it "has a link for each discount to its show page" do
      visit "merchants/#{@merchant_1.id}/discounts"
      within "#discount-#{@discounts.first.id}" do
        click_link "#{@discounts.first.percentage * 100}% Discount"
      end

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/#{@discounts.first.id}")
    end
  end
end
