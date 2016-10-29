class TaxRatesController < ApplicationController
  before_action :find_tax_rate, only: [:edit, :update, :destroy]

  def index
    @tax_rates = TaxRate.ordered.all
  end

  def new
    @tax_rate = TaxRate.new
    render 'form'
  end

  def create
    @tax_rate = TaxRate.new(tax_rate_params)
    if @tax_rate.save
      redirect_to :tax_rates, flash: { notice: t('shop.tax_rates.create_notice')}
    else
      render 'form'
    end
  end

  def edit
    render 'form'
  end

  def update
    if @tax_rate.update(tax_rate_params)
      redirect_to [:edit, @tax_rate], flash: { notice: t('shop.tax_rates.update_notice')}
    else
      render 'form'
    end
  end

  def destroy
    @tax_rate.destroy
    redirect_to :tax_rates, flash: { notice: t('shop.tax_rates.destroy_notice')}
  end

  private
  def find_tax_rate
    @tax_rate = TaxRate.find(params[:id])
  end

  def tax_rate_params
    params.require(:tax_rate).permit(:name, :rate, :address_type, country_ids: [])
  end
end

