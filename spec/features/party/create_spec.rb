# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "viewing party create" do
  describe 'the new viewing party', :vcr do
    before(:each) do
      @sara = User.create!(name: 'Sara', email: 'fake@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
      @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'xzy6789', password_confirmation: 'xzy6789')
      @movie = MoviesFacade.movie_by_id(278)
    end

    it 'can navigate to the create new party page', :vcr do
      visit movie_show_path(@user, @movie.id)

      expect(page).to have_button("Create Viewing Party for #{@movie.title}")

      click_button "Create Viewing Party for #{@movie.title}"

      expect(current_path).to eq("/users/#{@user.id}/movies/#{@movie.id}/viewing_party/new")
    end

    it 'has a form to create a new viewing party' do
      visit new_viewing_party_path(@user.id, @movie.id)

      expect(page).to have_button('Discover Page')
      expect(page).to have_content("#{@movie.title}")
      expect(page).to have_content("Duration of party:")
      expect(page).to have_field(:movie_duration, with: 142)
      expect(page).to have_content("Day:")
      expect(page).to have_field(:date)
      expect(page).to have_content("Start time:")
      expect(page).to have_field(:time)
      expect(page).to have_content("Invite other users:")
      expect(page).to have_content(@sara.name)
      expect(page).to have_button("Create Party")
    end

    it 'creates a new viewing party and upon submit renders the party' do
      visit new_viewing_party_path(@user.id, @movie.id)

      fill_in(:date, with: "2018-01-02")
      fill_in(:time, with: "04:30:00 UST")

      click_button("Create Party")

      expect(current_path).to eq(user_show_path(@user))
      expect(page).to have_content(@movie.title)
      expect(page).to have_content("Status: hosting")
    end

    it 'has a sad path' do
      visit new_viewing_party_path(@user.id, @movie.id)

      fill_in(:time, with: "04:30:00 UST")
      click_button("Create Party")

      expect(page).to have_content("Invalid input. Please try again.")
      expect(current_path).to eq(new_viewing_party_path(@user.id, @movie.id))
    end
  end
end
