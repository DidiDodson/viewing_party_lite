# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "user create" do
  describe 'the user new' do
    it 'renders the new form' do
      visit root_path

      expect(page).to have_button('Create New User')

      click_button 'Create New User'

      expect(current_path).to eq(register_path)
    end

    it 'creates a new user' do
      visit register_path
      fill_in 'Name', with: 'Tammy Tanaka'
      fill_in 'Email', with:'tammy@fake_email.com'
      fill_in 'Password', with: 'Abc123'
      fill_in 'Password confirmation', with: 'Abc123'
      click_button 'Save'

      expect(page).to have_content("Tammy Tanaka's Dashboard")
      expect(page).to have_button("Discover Movies")
      expect(page).to have_content("Viewing Parties")
    end

    it 'sad path 1 - creates new user' do
      visit register_path
      fill_in "Name", with: "Tammy Tanaka"
      click_button "Save"

      expect(page).to have_content("Please enter valid email")
      expect(current_path).to eq(register_path)
    end

    it 'sad path 2 - creates new user' do
      visit register_path
      fill_in 'Name', with: ''
      fill_in 'Email', with:'tammy@fake_email.com'
      fill_in 'Password', with: 'Abc123'
      fill_in 'Password confirmation', with: 'Abc123'
      click_button "Save"

      expect(page).to have_content("Please enter valid name")
      expect(current_path).to eq(register_path)
    end

    it 'sad path 3 - creates new user' do
      visit register_path
      fill_in 'Name', with: 'Tammy Tanaka'
      fill_in 'Email', with:''
      fill_in 'Password', with: 'Abc123'
      fill_in 'Password confirmation', with: 'Abc123'
      click_button "Save"

      expect(page).to have_content("Please enter valid email")
      expect(current_path).to eq(register_path)
    end

    it 'sad path 4 - creates new user' do
      visit register_path
      fill_in 'Name', with: 'Tammy Tanaka'
      fill_in 'Email', with:'tammy@fake_email.com'
      fill_in 'Password', with: 'Abc123'
      fill_in 'Password confirmation', with: 'zxc123'
      click_button "Save"

      expect(page).to have_content("Please enter valid password")
      expect(current_path).to eq(register_path)
    end

    it 'sad path 5 - creates new user' do
      visit register_path
      fill_in 'Name', with: 'Tammy Tanaka'
      fill_in 'Email', with:'tammy@fake_email.com'
      fill_in 'Password', with: 'Abc123'
      fill_in 'Password confirmation', with: ''
      click_button "Save"

      expect(page).to have_content("Please enter valid password")
      expect(current_path).to eq(register_path)
    end

    it 'sad path 4 - creates new user' do
      visit register_path
      fill_in 'Name', with: 'Tammy Tanaka'
      fill_in 'Email', with:'tammy@fake_email.com'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: 'Abc123'
      click_button "Save"

      expect(page).to have_content("Please enter valid password")
      expect(current_path).to eq(register_path)
    end
  end
end
