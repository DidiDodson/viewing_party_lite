# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover page' do
  before(:each) do
    @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')

    visit user_login_path
    fill_in :email, with: 'tammy@fake_email.com'
    fill_in :password, with: 'Abc123'
    click_button 'Login'

    visit discover_show_path
  end

  it 'shows discover page' do
    expect(page).to have_content('Discover Movies')
    expect(page).to have_button('Find Top Rated Movies')
    expect(page).to have_button('Find Movies')
  end

  it 'can go to top rated movies page', :vcr do
    click_button 'Find Top Rated Movies'
    expect(current_path).to eq(movie_index_path)
  end
end
