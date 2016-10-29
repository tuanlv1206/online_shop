class PaymentsController < ApplicationController
  before_action :find_order
  before_action :find_payment

  def create
    payment = @order.payments.build(payment_params)
    if payment.save
      redirect_to @order, flash: { notice: t('shop.payments.create_notice') }
    else
      redirect_to @order, flash: { alert: payment.errors.full_messages.to_sentence }
    end
  end

  def destroy
    @payment.destroy
    redirect_to @order, flash: { notice: t('shop.payments.destroy_notice') }
  end

  def refund
    if request.post?
      @payment.refund!(params[:amount])
      redirect_to @order, flash: { notice: t('shop.payments.refund_notice') }
    else
      render layout: false
    end
  rescue Errors::RefundFailed => e
    redirect_to @order, flash: { alert: e.message }
  end

  private
  def find_order
    @order = Order.find(params[:order_id])
  end

  def find_payment
    @payment = @order.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :method, :reference)
  end
end
