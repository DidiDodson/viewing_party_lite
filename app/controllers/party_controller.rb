# frozen_string_literal: true

class PartyController < BaseController
  def new
    if session[:user_id]
      @party = Party.new
      @users = User.all
      @movie = MoviesFacade.movie_by_id(params[:id])
      @party.movie_id = @movie.id
    else
      flash[:alert] = "Error: You must be logged in or registered to create a movie party"
      redirect_to "/movie/#{params[:movie_id]}"
    end
  end

  def create
     @host = User.find(session[:user_id])
     party = Party.new(party_params)
     user = User.find(params[:user_id])
     user_ids = params[:users]
     @movie = MoviesFacade.movie_by_id(params[:id])
     party.movie_id = @movie.id

     # movie = MoviesFacade.movie_by_id(party.movie_id)

    if party.save
      party.users << user
      user_ids.each do |id|
        invitee = User.find(id.to_i)
        party.users << invitee
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
