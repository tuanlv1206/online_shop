class SessionsController < ApplicationController
  layout 'sub'
  skip_before_filter :login_required, only: [:new, :create]

  def create
    if user = User.authenticate(params[:email_address], params[:password])
      session[:user_id] = user.id
      redirect_to :orders
    else
      flash.now[:alert] = t('shop.sessions.create_alert')
      render action: 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :login
  end
end
