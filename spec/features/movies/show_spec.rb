# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie show page' do
  describe 'movie show methods' do
    before(:each) do
      @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
      @movie = MoviesFacade.movie_by_id(278)
      @movie_cast = MoviesFacade.movie_cast(278)
      @movie_reviews = MoviesFacade.movie_reviews(278)
      @hours = @movie.runtime/60
      @minutes = (@movie.runtime.to_f%60).to_i

      visit user_login_path
      fill_in :email, with: 'tammy@fake_email.com'
      fill_in :password, with: 'Abc123'
      click_button 'Login'

      visit movie_show_path(@movie.id)
    end

    it 'has button to return to discover page', :vcr do
      expect(page).to have_button('Discover Page')

      click_button 'Discover Page'

      expect(current_path).to eq(discover_show_path)
    end

    it 'has button to create viewing party', :vcr do
      expect(page).to have_button("Create Viewing Party for #{@movie.title}")

      click_button "Create Viewing Party for #{@movie.title}"

      expect(current_path).to eq(new_viewing_party_path(@movie.id))
    end

    it 'has movie details from API', :vcr do

      expect(page).to have_content(@movie.title)
      expect(page).to have_content(@movie.vote_average)
      expect(page).to have_content('Drama')
      expect(page).to have_content('Runtime')
      expect(page).to have_content(@hours)
      expect(page).to have_content(@minutes)
      expect(page).to have_content(@movie.overview)
      expect(page).to have_content('Andy Dufresne')
      expect(page).to have_content('John Chard')
    end
  end

  describe 'authorization methods' do
    it 'throws an error if a user tries to access the dashboard without logging in' do
      visit '/movies/278'

      expect(page).to have_content('Please login or create new user account.')

      expect(current_path).to eq(root_path)
    end
  end
end
