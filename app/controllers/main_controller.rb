# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @users = User.all
  end
end
