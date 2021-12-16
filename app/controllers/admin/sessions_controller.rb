class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to admin_dashboard_path
      else
        redirect_to admin_user_login_path
        flash[:alert] = 'Please enter valid email or password'
      end
    else
      redirect_to admin_user_login_path
      flash[:alert] = 'Please enter valid email or password'
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
