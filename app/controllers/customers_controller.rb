class CustomersController < ApplicationController
  before_action :find_customer, only: [:show, :edit, :update, :destroy]

  def index
    @query = Customer.ordered.page(params[:page]).search(params[:q])
    @customers = @query.result
  end

  def new
    @customer = Customer.new
  end

  def show
    @addresses = @customer.addresses.ordered.load
    @orders = @customer.orders.ordered.load
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, flash: { notice: t('shop.customers.created_successfully') }
    else
      render 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, flash: { notice: t('shop.customers.updated_successfully') }
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, flash: { notice: t('shop.customers.deleted_successfully') }
  end

  def search
    index
    render 'index'
  end

  private

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params[:customer].permit(:first_name, :last_name, :company, :email, :phone, :mobile)
  end
end
