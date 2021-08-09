require 'rails_helper'

RSpec.describe 'new merchant discount page' do
  describe 'page form' do
    it 'can fill out form to create a new ' do
      merchant = create(:merchant)
      visit new_merchant_discount_path(merchant.id)

      fill_in :percentage, with: 20
      fill_in :quantity_threshold, with: 10
      click_on 'Submit'

      new_discount = Discount.last

      expect(current_path).to eq(merchant_discounts_path(merchant.id))
      expect(page).to have_content(new_discount.percentage.to_i)
      expect(page).to have_content(new_discount.quantity_threshold)
    end
  end
end
