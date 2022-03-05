# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_dashboard_path
    elsif params[:name].present? == false
      redirect_to register_path
      flash[:alert] = 'Please enter valid name'
    elsif params[:email].present? == false || User.exists?(email: params[:email]) == true
      redirect_to register_path
      flash[:alert] = 'Please enter valid email'
    elsif params[:password].present? == false
      redirect_to register_path
      flash[:alert] = 'Please enter valid password'
    elsif params[:password_confirmation] != params[:password] || params[:password_confirmation].present? == false
      redirect_to register_path
      flash[:alert] = 'Please enter valid password confirmation'
    end
  end

  def show
    if session[:user_id] == nil
      flash[:alert] = "Please login or create new user account."
      redirect_to root_path
    else
      @user = User.find(session[:user_id])
      @parties = @user.parties
      @movies = @user.parties.map do |party|
        MoviesFacade.movie_by_id(party.movie_id)
      end

    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def party_params
    params.permit(:id, :name, :date, :time, :movie_id, :movie_duration)
  end
end
