class Discount < ApplicationRecord
  belongs_to :merchant
  validates :merchant_id, presence: true
  validates :percentage, presence: true
  validates :threshold, presence: true
  validates :percentage, numericality: true
  validates :threshold, numericality: true

  def self.max_discount(item_invoice)
    joins(merchant: :invoice_items)
    .where("threshold <=?", item_invoice.quantity)
    .last
  end
end
