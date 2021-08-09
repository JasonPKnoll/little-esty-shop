class Discount < ApplicationRecord
  belongs_to :merchant

  # validates :percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100, only_integer: true}
  # validates :quantity_threshold, numericality: { greater_than: 0, only_integer: true}
  #
  # scope :percentage, -> {:percentage / 100}
end
