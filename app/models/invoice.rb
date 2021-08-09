class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

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

  def total_revenue_for_merchant(merchant_id)
    items.joins(:invoice_items).where('items.merchant_id = ?', merchant_id).sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def item_discount(item_id)
    item = Item.find(item_id)
    merchant = item.merchant
    it = InvoiceItem.find_by(item_id: item_id, invoice_id: self.id)

    max_percentage = merchant.discounts.where('quantity_threshold <= ?', it.quantity).max_by { |discount| discount.percentage }

    max_percentage.nil? ? 0.0 : max_percentage.percentage
  end

  def discounted_amount(item_id)
    item = Item.find(item_id)
    it = InvoiceItem.find_by(item_id: item.id, invoice_id: self.id)

    ((it.quantity * it.unit_price).to_f - ((it.quantity * it.unit_price) * item_discount(item.id)))
  end

  def discounted_revenue(merchant_id)
    merchant = Merchant.find(merchant_id)
    items = merchant.items

    merchant.discounts.empty? ? total_revenue_for_merchant(merchant_id) : items.sum { |item| discounted_amount(item.id) }
  end
end



# self.merchants.joins(:invoice_items).joins(:discounts).select(:invoice_items, :discounts).where('invoice_items.quantity >= discounts.quantity_threshold').distinct.sum('(invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * discounts.percentage)').to_i

#  self.merchants.joins(:invoice_items).joins(:discounts).select(:invoice_items, :discounts).where('invoice_items.quantity >= discounts.quantity_threshold').distinct.sum('(CASE
# #               WHEN invoice_items.quantity >= discounts.quantity_threshold
# #                  THEN SUM(invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * discounts.percentage)
# #               END))').to_i


# joins(:discounts).select(:invoice_items, :discounts).where('invoice_items.quantity >= discounts.quantity_threshold').distinct.sum('(invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * discounts.percentage)').to_i


# self.merchants.joins(:invoice_items).joins(:discounts).group('invoice_items.id, discounts.id').select('invoice_items.*, discounts.*, (CASE
#               WHEN invoice_items.quantity >= discounts.quantity_threshold
#                  THEN SUM(invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * discounts.percentage)
#               ELSE SUM(invoice_items.quantity * invoice_items.unit_price)
#               END) AS revenue')
#
# count = 0
# x = discounts.uniq.sort {|a, b| b <=> a }
# x.each do |discount|
#   invoice_items.uniq.each do |it|
#     if it.quantity >= discount.quantity_threshold
#       count += ((it.quantity * it.unit_price) - ((it.quantity * it.unit_price) * discount.percentage))
#       invoice_items.delete(it)
#     end
#   end
# end
#
# count = 0
# x = discounts.uniq.sort {|a, b| b <=> a }
# x.each do |discount|
#   invoice_items.uniq.each do |it|
#       count += ((it.quantity * it.unit_price) - ((it.quantity * it.unit_price) * discount.percentage))if it.quantity >= discount.quantity_threshold
#     end
#   end

# count.to_i

# self.merchants.joins(:discounts)
# .joins(:invoice_items)
# .select(:invoice_items, :discounts)
# .where('invoice_items.quantity >= discounts.quantity_threshold').distinct
# .sum('(invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * discounts.percentage)').to_i
