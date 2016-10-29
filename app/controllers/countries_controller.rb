class CountriesController < ApplicationController
  before_action :find_country, only: [:edit, :update, :destroy]

  def index
    @countries = Country.ordered
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to :countries, {:flash => { notice: t('shop.countries.create_notice')}}
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @country.update(country_params)
      redirect_to [:edit, @country], flash: { notice: t('shop.countries.update_notice')}
    else
      render 'edit'
    end
  end

  def destroy
    @country.destroy
    redirect_to :countries, flash: { notice: t('shop.countries.destroy_notice')}
  end

  private
  def find_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:name, :code2, :code3, :continent, :tld, :currency, :eu_member)
  end
end
