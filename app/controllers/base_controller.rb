class BaseController < ApplicationController
  before_action :require_user

  def require_user
    if !current_user
      flash[:alert] = "You must be registered and logged in."
      redirect_to root_path
    end
  end
end
