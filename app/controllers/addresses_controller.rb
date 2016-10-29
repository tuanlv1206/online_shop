class AddressesController < ApplicationController
  before_filter { params[:customer_id] && @customer = Customer.find(params[:customer_id]) }
  before_filter { params[:id] && @address = @customer.addresses.find(params[:id]) }

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = @customer.addresses.build(safe_params)

    @address.default = true if @customer.addresses.count == 0

    if @customer.save
      redirect_to @customer, flash: { notice: t('shop.addresses.created_successfully') }
    else
      render action: 'new'
    end
  end

  def update
    if @address.update(safe_params)
      redirect_to @customer, flash: { notice: t('shop.addresses.updated_successfully') }
    else
      render action: 'edit'
    end
  end

  def destroy
    @address.destroy
    redirect_to @customer, flash: { notice: t('shop.addresses.deleted_successfully') }
  end

  private

  def safe_params
    params[:address].permit(:address_type, :address1, :address2, :address3, :address4, :postcode, :country_id)
  end
end
