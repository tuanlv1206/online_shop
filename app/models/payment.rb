class Payment < ApplicationRecord
  extend ActiveModel::Callbacks
  define_model_callbacks :refund

  belongs_to :order
  belongs_to :parent, class_name: 'Payment', foreign_key: 'parent_payment_id'

  # Validations
  validates :amount, numericality: true
  validates :reference, presence: true
  validates :method, presence: true

  # Callbacks
  after_create :cache_amount_paid
  after_destroy :cache_amount_paid
  before_destroy { parent.update_attribute(:amount_refunded, parent.amount_refunded + amount) if parent}

  # Is this payment a refund?
  def refund?
    amount_refunded > BigDecimal(0)
  end

  # Has this payment had any refunds taken from it?
  def refunded?
    amount_refunded > BigDecimal(0)
  end

  # How much of the payment can be refunded
  def refundable_amount
    refundable? ? (amount - amount_refunded) : BigDecimal(0)
  end

  # Process a refund from this payment
  def refund!(amount)
    run_callback :refund do
      amount = BigDecimal(amount)
      if refundable_amount >= amount
        transaction do
          self.class.create(parent: self, order_id: order_id, amount: 0 - amount, method: method, reference: reference)
          update_attribute(:amount_refunded, amount_refunded + amount)
          true
        end
      else
        fails Errors::RefundFailed, message: I18.t('.refund_failed', refundable_amount: refundable_amount)
      end
    end
  end

  # Return a transaction URL for viewing further information about this payments
  def transaction_url
    nil
  end

  private
  def cache_amount_paid
    order.update_attribute(:amount_paid, order.payments.sum(:amount))
  end
end
