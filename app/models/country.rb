class Country < ApplicationRecord

  # All orders which have this country set as their billing country
  has_many :billed_orders, dependent: :restrict_with_exception, class_name: 'Order', foreign_key: 'billing_country_id'

  # All orders which have this country set as their delivery country
  has_many :delivered_orders, dependent: :restrict_with_exception, class_name: 'Order', foreign_key: 'delivery_country_id'
  # All countries ordered by their name ascending
  scope :ordered, ->{ order(name: :asc)}

  # Validations
  validates :name, presence: true
end
