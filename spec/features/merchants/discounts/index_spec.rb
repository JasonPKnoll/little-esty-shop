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
  end
end
