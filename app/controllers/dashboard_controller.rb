class DashboardController < ApplicationController
  def home
    redirect_to :orders
  end
end
