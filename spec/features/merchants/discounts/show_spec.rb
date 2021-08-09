require 'rails_helper'

RSpec.describe 'discount show page' do
  describe 'contents' do
    it 'displays discount quantity threshold and percentage discount' do
      merchant = create(:merchant)
      discount = merchant.discounts.create!(percentage: 10, quantity_threshold: 10)

      visit merchant_discount_path(merchant.id, discount.id)

      expect(page).to have_content("Discount: #{discount.percentage.to_i}%")
      expect(page).to have_content("Number of Items #{discount.quantity_threshold}")
    end

    it 'displays a link to edit the discount information and when clicking the link, merchant is directed to an edit page' do
      merchant = create(:merchant)
      discount = merchant.discounts.create!(percentage: 10, quantity_threshold: 10)

      visit merchant_discount_path(merchant.id, discount.id)

      expect(page).to have_link('Edit Discount')

      click_link 'Edit Discount'

      expect(current_path).to eq(edit_merchant_discount_path(merchant.id, discount.id))
    end
  end
end
