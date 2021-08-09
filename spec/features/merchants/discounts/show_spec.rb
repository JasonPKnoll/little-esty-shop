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
  end
end
