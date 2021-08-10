class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items
  enum status: { cancelled: 0,  "in progress"  => 1, completed: 2 }

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not('invoice_items.status = 2')
    .select('invoices.id, invoices.created_at')
    .order(:created_at)
    .distinct
  end

  def total_revenue
    invoice_items.sum('quantity * unit_price')
  end

  def total_discounted_revenue
    require "pry"; binding.pry
    discounts = []
    invoice_items.each do |invoice_item|
      if invoice_item.max_discount != nil
        x = invoice_item.unit_price * (invoice_item.max_discount.percentage / 100)
        discounts << x * invoice_item.quantity
      end
    end
    (total_revenue - discounts.sum).to_i
  end
end
