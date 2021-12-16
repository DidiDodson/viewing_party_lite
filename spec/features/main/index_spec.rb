# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Main page' do
  it 'has main page details' do
    visit '/'

    expect(page).to have_content('Viewing Party Lite')
    expect(page).to have_link('Home')
    expect(page).to have_content('Existing Users:')
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
    click_link("Login")

    expect(current_path).to eq(user_login_path)
  end
end
