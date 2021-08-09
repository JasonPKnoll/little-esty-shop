require 'rails_helper'

RSpec.describe 'Merchants invoices show page' do
  describe "invoices" do
    before(:each) do
      @merchant_1 = create(:merchant)

      @customers = []
      @invoices = []
      @items = []
      @transactions = []
      @invoice_items = []

      5.times do
        @customers << create(:customer)
        @invoices << create(:invoice, customer_id: @customers.last.id, created_at: DateTime.new(2020,2,3,4,5,6))
        @items << create(:item, merchant_id: @merchant_1.id, unit_price: 20)
        @transactions << create(:transaction, invoice_id: @invoices.last.id)
        @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1, quantity: 10, unit_price: @items.last.unit_price)
      end

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}"
    end

    it "has path to page" do
      expect(page).to have_content("Invoice ##{@invoices[0].id}")
    end

    it "shows correct date format created at" do
      expect(page).to have_content("Monday February 3, 2020")
    end

    it "has all attributes" do
      expect(page).to have_content("#{@invoices[0].status}")
      expect(page).to have_content("#{@invoices[0].id}")
      expect(page).to have_content("Monday February 3, 2020")
      expect(page).to have_content("#{@customers[0].first_name}")
      expect(page).to have_content("#{@customers[0].last_name}")
    end

    it "can list total revenue" do
      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 1598)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices[0].id, status: 1, quantity: 10, unit_price: @items.last.unit_price)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}"
      expect(page).to have_content("Total Revenue: $161.80")

    end

    it "allows merchant to select invoice status" do
      expect(@invoice_items[0].status).to eq("packaged")

      page.select "shipped", from: 'status'
      click_button "Update Item Status"

      expect(page).to have_content("shipped")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}")
    end
  end

  describe 'total revenue and discounted revenue' do
    it 'displays the total revenue as well as the total discounted revenue for the merchant from this invoice' do
      merchant = create(:merchant)
      discount = create(:discount, merchant: merchant)
      item1 = create(:item, merchant: merchant, unit_price: 20)
      item2 = create(:item, merchant: merchant, unit_price: 45)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)
      transaction1 = create(:transaction, invoice: invoice)
      transaction2 = create(:transaction, invoice: invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, unit_price: 20, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice, unit_price: 45, quantity: 5)

      visit merchant_invoice_path(merchant.id, invoice.id)

      expect(page).to have_content("Discounted Revenue: $#{invoice.discounted_revenue(merchant.id)}")
    end

    it 'displays a link to discount show page if discount was applied' do
      merchant = create(:merchant)
      discount = create(:discount, merchant: merchant)
      item1 = create(:item, merchant: merchant, unit_price: 20)
      item2 = create(:item, merchant: merchant, unit_price: 45)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)
      transaction1 = create(:transaction, invoice: invoice)
      transaction2 = create(:transaction, invoice: invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, unit_price: 20, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice, unit_price: 45, quantity: 5)

      visit merchant_invoice_path(merchant.id, invoice.id)

      expect(page).to have_link(discount.name)
    end

    it 'when clicking the link to the applied discount, merchant is directed to discount show page' do
      merchant = create(:merchant)
      discount = create(:discount, merchant: merchant)
      item1 = create(:item, merchant: merchant, unit_price: 20)
      item2 = create(:item, merchant: merchant, unit_price: 45)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)
      transaction1 = create(:transaction, invoice: invoice)
      transaction2 = create(:transaction, invoice: invoice)
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice, unit_price: 20, quantity: 10)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice, unit_price: 45, quantity: 5)

      visit merchant_invoice_path(merchant.id, invoice.id)

      click_on discount.name

      expect(current_path).to eq(visit merchant_discount_path(merchant.id, discount.id))
    end
  end
end
