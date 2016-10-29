class DeliveryService < ApplicationRecord

  # Validations
  validates :name, presence: true
  validates :courier, presence: true

  # Orders which are assigned to this delivery service
  has_many :orders, dependent: :restrict_with_exception

  # Prices for the different levels of service within this delivery service
  has_many :delivery_service_prices, dependent: :destroy

  # All active delivery services
  scope :active, -> {where(active: true)}

  # Return a tracking URL for the passed order
  #
  # @param order [Order]
  # @return [String] the full URL for the order.
  def tracking_url_for(order)
    return nil if tracking_url.blank?
    tracking_url = self.tracking_url.dup
    tracking_url.gsub!('{{consignment_number}}', CGI.escape(order.consignment_number.to_s))
    tracking_url.gsub!('{{delivery_postcode}}', CGI.escape(order.delivery_postcode.to_s))
    tracking_url.gsub!('{{billing_postcode}}', CGI.escape(order.billing_postcode.to_s))
  end

end
