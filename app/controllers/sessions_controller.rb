class SessionsController < ApplicationController

  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        redirect_to user_show_path(@user)
      else
        redirect_to user_login_path
        flash[:alert] = 'Please enter valid email or password'
      end
    else
      redirect_to user_login_path
      flash[:alert] = 'Please enter valid email or password'
    end
  end
end
