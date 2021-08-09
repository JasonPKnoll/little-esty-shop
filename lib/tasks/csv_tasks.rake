require 'csv'

namespace :csv do
  task :import_customers => :environment do
    CSV.foreach("db/data/customers.csv", :headers => true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task :import_invoice_items => :environment do
    CSV.foreach("db/data/invoice_items.csv", :headers => true) do |row|
      # row = row.to_hash
      # row[:unit_price] = row[:unit_price].to_f / 100
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task :import_invoices => :environment do
    CSV.foreach("db/data/invoices.csv", :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task :import_items => :environment do
    CSV.foreach("db/data/items.csv", :headers => true) do |row|
      # row = row.to_hash
      # row[:unit_price] = row[:unit_price].to_f / 100
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task :import_merchants => :environment do
    CSV.foreach("db/data/merchants.csv", :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task :import_transactions => :environment do
    CSV.foreach("db/data/transactions.csv", :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task import_all: :environment do
    Rake::Task['csv:import_customers'].execute
    Rake::Task['csv:import_merchants'].execute
    Rake::Task['csv:import_items'].execute
    Rake::Task['csv:import_invoices'].execute
    Rake::Task['csv:import_invoice_items'].execute
    Rake::Task['csv:import_transactions'].execute
  end
end
