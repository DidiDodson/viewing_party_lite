# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "user dashboard" do
  describe 'basic methods' do
    before :each do
      @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
      @user2 = User.create!(name: 'Bob Smith', email: 'bob@fake_email.com', password: 'mnbu23', password_confirmation: 'mnbu23')

      visit user_login_path
      fill_in :email, with: 'tammy@fake_email.com'
      fill_in :password, with: 'Abc123'
      click_button 'Login'

      visit user_dashboard_path
    end

    it 'shows user details' do

      expect(page).to have_content("Tammy Tanaka's Dashboard")
      expect(page).to_not have_content("Bob Smith's Dashboard")
    end

    it 'has a button to discover movies' do
      expect(page).to have_button('Discover Movies')

      click_button 'Discover Movies'

      expect(current_path).to eq(discover_show_path)
    end

    it 'lists a users parties', :vcr do
      expect(page).to have_content('Viewing Parties')

      movie = Movie.new({ id: 1,
        title: "The Green Mile",
        runtime: 104,
        vote_average: 8.5,
        genres: "Drama",
        overview: "Movie about a guy"
      })

      party = Party.create!(name: movie.title, movie_id: movie.id, date: "2021-12-25", time:"13:21:00", movie_duration: '104', user_id: @user.id)
      party_invitee = PartyInvitee.create!(user_id: @user.id, party_id: party.id)

      visit(current_path)

      expect(page).to have_content(party.name)
    end
  end

  describe 'authorization methods' do
    it 'throws an error if a user tries to access the dashboard without logging in' do
      visit user_dashboard_path

      expect(page).to have_content('Please login or create new user account.')

      expect(current_path).to eq(root_path)
    end
  end
end
