# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@customer = create(:customer)

@invoice = create(:invoice, customer_id: @customer.id)

@merchant = create(:merchant)

@item1 = create(:item, merchant_id: @merchant.id)
@item2 = create(:item, merchant_id: @merchant.id)

@invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 0)
@invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 0)
@invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id, status: 1, unit_price: 100, quantity: 500)
@invoice_item4 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 1, unit_price: 100, quantity: 100)
@invoice_item5 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 2)
@invoice_item6 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice.id, status: 0)


@transaction1 = create(:transaction, invoice_id: @invoice.id)
@transaction2 = create(:transaction, invoice_id: @invoice.id)
@transaction3 = create(:transaction, invoice_id: @invoice.id)
@transaction4 = create(:transaction, invoice_id: @invoice.id)
@transaction5 = create(:transaction, invoice_id: @invoice.id)
@transaction6 = create(:transaction, invoice_id: @invoice.id)
@transaction7 = create(:transaction, invoice_id: @invoice.id)

@discount1 = create(:discount, merchant_id: @merchant.id, percentage: 50, threshold: 300)
@discount2 = create(:discount, merchant_id: @merchant.id, percentage: 25, threshold: 100)
