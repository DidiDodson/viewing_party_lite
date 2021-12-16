# frozen_string_literal: true

class PartyController < BaseController
  def new
    @user = User.find(session[:user_id])
    @movie = MoviesFacade.movie_by_id(params[:id])
  end

  def create
    user = User.find(session[:user_id])
    movie = MoviesFacade.movie_by_id(params[:movie_id])
    party = Party.new(party_params)
    party.user_id = session[:user_id]
    party.movie_id = movie.id
    params[:user_ids] << session[:user_id].to_s
    ids = params[:user_ids]
    ids.shift

    if party.save
      ids.map do |user_id|
        PartyInvitee.create(user_id: user_id, party_id: party.id)
      end
      redirect_to user_dashboard_path
    else
      flash[:alert] = 'Invalid input. Please try again.'
      redirect_to new_viewing_party_path(movie.id)
    end
  end

  private

  def party_params
    params.permit(:user_id, :name, :date, :time, :movie_id, :movie_duration, user_ids: [])
  end

  def movie_params
    params.permit(:movie_id, :title)
  end
end
