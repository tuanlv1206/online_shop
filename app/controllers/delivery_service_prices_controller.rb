class DeliveryServicePricesController < ApplicationController
  before_action :find_delivery_service
  before_action :find_delivery_service_price, only: [:edit, :update, :destroy]

  def index
    @delivery_service_prices = @delivery_service.delivery_service_prices.ordered
  end

  def new
    @delivery_service_price = @delivery_service.delivery_service_prices.build
  end

  def create
    @delivery_service_price = @delivery_service.delivery_service_prices.build(delivery_service_price_params)
    if @delivery_service_price.save
      redirect_to [@delivery_service, :delivery_service_prices], notice: t('shop.delivery_service_prices.create_notice')
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @delivery_service_price.update(delivery_service_price_params)
      redirect_to [@delivery_service, :delivery_service_prices], notice: t('shop.delivery_service_prices.update_notice')
    else
      render 'edit'
    end
  end

  def destroy
    @delivery_service_price.destroy
    redirect_to [@delivery_service, :delivery_service_prices], notice: t('shop.delivery_service_prices.destroy_notice')
  end

  private

    def find_delivery_service
      @delivery_service = DeliveryService.find(params[:delivery_service_id])
    end

    def find_delivery_service_price
      @delivery_service_price = @delivery_service.delivery_service_prices.find(params[:id])
    end

    def delivery_service_price_params
      params.require(:delivery_service_price).permit(:price, :cost_price, :tax_rate_id, :min_weight, :max_weight, :code, country_ids: [])
    end
end
