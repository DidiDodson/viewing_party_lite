class Admin::UsersController < BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:user_id])
    @parties = @user.parties
    @movies = @user.parties.map do |party|
      MoviesFacade.movie_by_id(party.movie_id)
    end
  end
end
