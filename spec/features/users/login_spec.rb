require 'rails_helper'

RSpec.describe "user login" do
  before :each do
    @user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
    @user2 = User.create!(name: 'Bob Smith', email: 'bob@fake_email.com', password: 'mnbu23', password_confirmation: 'mnbu23')
    visit '/login'
  end

  it 'shows login form' do
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")
  end

  it 'happy path - it takes you to user show page' do
    fill_in 'Email', with: 'tammy@fake_email.com'
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(user_show_path(@user))

    expect(page).to have_content("Tammy Tanaka's Dashboard")
    expect(page).to_not have_content("Bob Smith's Dashboard")
  end

  it 'sad path 1 - it takes you to user show page' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(user_login_path)

    expect(page).to have_content('Please enter valid email')
  end

  it 'sad path 2 - it takes you to user show page' do
    fill_in 'Email', with: 'tammy@fake_email.com'
    fill_in 'Password', with: ''
    click_button('Login')

    expect(current_path).to eq(user_login_path)

    expect(page).to have_content('Please enter valid email or password')
  end

  it 'sad path 3 - it takes you to user show page' do
    fill_in 'Email', with: 'dingdong@fake_email.com'
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(user_login_path)

    expect(page).to have_content('Please enter valid email or password')
  end
end
