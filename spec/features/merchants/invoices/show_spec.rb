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
      @discounts = []

      2.times do
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

    it "shows total discounted revenue for this invoice" do
      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 5000)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices[0].id, status: 1, quantity: 500, unit_price: @items.last.unit_price)

      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 1000)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices[0].id, status: 1, quantity: 100, unit_price: @items.last.unit_price)

      @discounts << create(:discount, percentage: 20.0, threshold: 50, merchant_id: @merchant_1.id)
      @discounts << create(:discount, percentage: 50.0, threshold: 200, merchant_id: @merchant_1.id)

      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}"

      #items
      #quantity: 10 - unit_price: 20
      #quantity: 500 - unit_price: 5000
      #quantity: 100 - unit_price: 1000
      expect(page).to have_content("$13,302.00")
    end

    it "has links to each discount show page" do
      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 5000)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices[0].id, status: 1, quantity: 500, unit_price: @items.last.unit_price)

      @items << create(:item, merchant_id: @merchant_1.id, unit_price: 1000)
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices[0].id, status: 1, quantity: 100, unit_price: @items.last.unit_price)

      @discounts << create(:discount, percentage: 20.0, threshold: 50, merchant_id: @merchant_1.id)
      @discounts << create(:discount, percentage: 50.0, threshold: 200, merchant_id: @merchant_1.id)


      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoices[0].id}"

      within("#id-#{@invoice_items[3].id}") do
        expect(page).to have_content("Discount Applied")
      end
      within("#id-#{@invoice_items[2].id}") do
        expect(page).to have_content("Discount Applied")
      end
    end
  end
end
