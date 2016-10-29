class DeliveryServicesController < ApplicationController
  before_action :find_delivery_service, only: [:edit, :update, :destroy]

  def index
    @delivery_services = DeliveryService.all
  end

  def new
    @delivery_service = DeliveryService.new
  end

  def create
    @delivery_service = DeliveryService.new(delivery_service_params)
    if @delivery_service.save
      redirect_to :delivery_services, flash: { notice: t('shop.delivery_services.create_notice')}
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @delivery_service.update(delivery_service_params)
      redirect_to [:edit, @delivery_service], flash: { notice: t('shop.delivery_services.update_notice')}
    else
      render 'edit'
    end
  end

  def destroy
    @delivery_service.destroy
    redirect_to :delivery_services, flash: { notice: t('shop.delivery_services.destroy_notice')}
  end

  private

    def find_delivery_service
      @delivery_service = DeliveryService.find(params[:id])
    end

    def delivery_service_params
      params.require(:delivery_service).permit(:name, :code, :active, :default, :courier, :tracking_url)
    end
end
