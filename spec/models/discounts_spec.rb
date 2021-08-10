require 'rails_helper'

RSpec.describe Discount do
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it { should validate_presence_of :percentage }
    it { should validate_numericality_of :percentage }
    it { should validate_presence_of :threshold }
    it { should validate_numericality_of :threshold }
    it { should validate_presence_of :merchant_id }
  end

  describe 'class methods' do
    it 'displays largest discount' do
      merchant = create(:merchant)
      customer = create(:customer)

      item_1 = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 15)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 30)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 75)
      invoice_item_4 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 99)
      invoice_item_5 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 150)

      discount_1 = create(:discount, percentage: 20.0, threshold: 25, merchant_id: merchant.id)
      discount_2 = create(:discount, percentage: 25.0, threshold: 50, merchant_id: merchant.id)
      discount_3 = create(:discount, percentage: 30.0, threshold: 75, merchant_id: merchant.id)
      discount_4 = create(:discount, percentage: 45.0, threshold: 100, merchant_id: merchant.id)
      discount_5 = create(:discount, percentage: 50.0, threshold: 125, merchant_id: merchant.id)

      expect(Discount.max_discount(invoice_item_1)).to eq(nil)
      expect(Discount.max_discount(invoice_item_2)).to eq(discount_1)
      expect(Discount.max_discount(invoice_item_3)).to eq(discount_3)
      expect(Discount.max_discount(invoice_item_4)).to eq(discount_3)
      expect(Discount.max_discount(invoice_item_5)).to eq(discount_5)
    end
  end
end
