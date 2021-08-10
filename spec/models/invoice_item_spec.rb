require 'rails_helper'

RSpec.describe InvoiceItem do
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
      @invoice_items << create(:invoice_item, item_id: @items.last.id, invoice_id: @invoices.last.id, status: 1, quantity: 100, unit_price: @items.last.unit_price)
    end
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should define_enum_for(:status).with([:pending, :packaged, :shipped]) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'class methods' do
    describe '#total_revenue' do
      it 'can calculate the total revenue on an invoice' do
        expect(InvoiceItem.total_revenue).to eq(10000)
      end
    end

    describe  "#max_discount" do
      it 'can return only the top discount' do
        merchant = create(:merchant)
        customer = create(:customer)

        item_1 = create(:item, merchant_id: merchant.id)
        invoice = create(:invoice, customer_id: customer.id)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 15)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 30)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 75)
        invoice_item_4 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 99)
        invoice_item_5 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 150)

        discount_1 = create(:discount, percentage: 20.0., threshold: 25, merchant_id: merchant.id)
        discount_2 = create(:discount, percentage: 25.0, threshold: 50, merchant_id: merchant.id)
        discount_3 = create(:discount, percentage: 30.0, threshold: 75, merchant_id: merchant.id)
        discount_4 = create(:discount, percentage: 45.0, threshold: 100, merchant_id: merchant.id)
        discount_5 = create(:discount, percentage: 50.0, threshold: 125, merchant_id: merchant.id)

        expect(invoice_item_1.max_discount).to eq(nil)
        expect(invoice_item_2.max_discount).to eq(discount_1)
        expect(invoice_item_3.max_discount).to eq(discount_3)
        expect(invoice_item_4.max_discount).to eq(discount_3)
        expect(invoice_item_5.max_discount).to eq(discount_5)
      end
    end
  end
end
