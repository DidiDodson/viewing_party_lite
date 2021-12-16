# frozen_string_literal: true

class DiscoverController < BaseController
  def show
    @user = User.find(session[:user_id])
  end
end
