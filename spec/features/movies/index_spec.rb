# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Top rated movies page' do
  before(:each) do
    @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')

    visit movie_index_path(@user)
  end

  it 'has button to return to discover page', :vcr do
    expect(page).to have_button('Discover Page')

    click_button 'Discover Page'

    expect(current_path).to eq(discover_show_path(@user))
  end

  it 'shows top 40 movies', :vcr do
    movie = MoviesFacade.top_40.first

    within("#topmovies") do
      expect(page).to have_link(movie.title)
      expect(page).to have_content(movie.vote_average)
    end
  end

  it 'finds movies by title', :vcr do
    movie = MoviesFacade.movies_by_title('Shawshank Redemption')

    within("#topmovies") do
      expect(page).to have_link(movie.first.title)
      expect(page).to have_content(movie.first.vote_average)
    end
  end
end
