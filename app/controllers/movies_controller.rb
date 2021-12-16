# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @movies = if params[:title]
      MoviesFacade.movies_by_title(params[:title])
    else
      MoviesFacade.top_40
    end
  end

  def show
    if session[:user_id] == nil
      flash[:alert] = "Please login or create new user account."
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
      @movie = MoviesFacade.movie_by_id(params[:id])
      @movie_cast = MoviesFacade.movie_cast(params[:id])
      @movie_reviews = MoviesFacade.movie_reviews(params[:id])
    end
  end
end
