# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant1 = Merchant.create!(
                        name: Faker::Company.name,
                        enabled: true)
discount1 = Discount.create!(
                        percentage: 0.2,
                        quantity_threshold: 10,
                        merchant: merchant1)

item1 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 20,
                    merchant: merchant1)
item2 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 45,
                    merchant: merchant1)
customer1 = Customer.create!(
                            first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
invoice1 = Invoice.create!(
                          status: 0,
                          customer: customer1)
transaction1 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice1)
transaction2 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice1)
invoice_item1 = InvoiceItem.create!(
                            quantity: 10,
                            unit_price: 20,
                            item: item1,
                            invoice: invoice1)
invoice_item2 = InvoiceItem.create!(
                            quantity: 5,
                            unit_price: 45,
                            item: item2,
                            invoice: invoice1)

# 2 items meet the discount threhold on the invoice
merchant2 = Merchant.create!(
                        name: Faker::Company.name,
                        enabled: true)
discount2 = Discount.create!(
                        percentage: 0.2,
                        quantity_threshold: 10,
                        merchant: merchant2)
item3 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 20,
                    merchant: merchant2)
item4 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 45,
                    merchant: merchant2)
item5 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 30,
                    merchant: merchant2)
customer2 = Customer.create!(
                            first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
invoice2 = invoice1 = Invoice.create!(
                          status: 0,
                          customer: customer2)
transaction3 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice2)
transaction4 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice2)
invoice_item3 = InvoiceItem.create!(
                            quantity: 10,
                            unit_price: 20,
                            item: item3,
                            invoice: invoice2)
invoice_item4 = InvoiceItem.create!(
                            quantity: 5,
                            unit_price: 45,
                            item: item4,
                            invoice: invoice2)
invoice_item5 = InvoiceItem.create!(
                            quantity: 12,
                            unit_price: 30,
                            item: item5,
                            invoice: invoice2)

# 1 item meets the lower discount threhold and 1 item meets the 2nd discount item threshold on the invoice
merchant3 = Merchant.create!(
                        name: Faker::Company.name,
                        enabled: true)
discount3 = Discount.create!(
                        percentage: 0.2,
                        quantity_threshold: 10,
                        merchant: merchant3)
discount4 = Discount.create!(
                        percentage: 0.3,
                        quantity_threshold: 15,
                        merchant: merchant3)
item6 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 20,
                    merchant: merchant3)
item7 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 45,
                    merchant: merchant3)
item8 = Item.create!(
                    name: Faker::Device.model_name,
                    description: Faker::Quote.yoda,
                    unit_price: 30,
                    merchant: merchant3)
customer3 = Customer.create!(
                            first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
invoice3 = invoice1 = Invoice.create!(
                          status: 0,
                          customer: customer3)
transaction5 = transaction3 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice3)
transaction6 = transaction3 = Transaction.create!(
                                  credit_card_number: Faker::Finance.credit_card,
                                  credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
                                  result: 0,
                                  invoice: invoice3)
invoice_item6 = InvoiceItem.create!(
                            quantity: 10,
                            unit_price: 10,
                            item: item6,
                            invoice: invoice3)
invoice_item7 = InvoiceItem.create!(
                            quantity: 5,
                            unit_price: 45,
                            item: item7,
                            invoice: invoice3)
invoice_item8 = InvoiceItem.create!(
                            quantity: 15,
                            unit_price: 10,
                            item: item8,
                            invoice: invoice3)
