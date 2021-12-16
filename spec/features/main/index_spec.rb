# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Main page' do
  describe 'before login' do
    it 'has main page details' do
      visit '/'

      expect(page).to have_content('Viewing Party Lite')
      expect(page).to have_link('Home')
      expect(page).to have_button("Create New User")
      expect(page).to have_link('Login')
    end

    it 'goes to create user page' do
      visit '/'
      click_button("Create New User")

      expect(current_path).to eq(register_path)
    end

    it 'goes to user login page' do
      visit '/'
      click_link('Login')

      expect(current_path).to eq(user_login_path)
    end
  end

  describe 'after login' do
    it 'shows the logout link' do
      @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')

      visit user_login_path
      fill_in :email, with: 'tammy@fake_email.com'
      fill_in :password, with: 'Abc123'
      click_button 'Login'

      visit '/'
      expect(page).to have_content('Logout')
      expect(page).to_not have_content('Login')

      click_link('Logout')

      expect(current_path).to eq('/')
    end
  end
end
