require 'rails_helper'

RSpec.describe "admin login" do
  before :each do
    @admin = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
    @user2 = User.create!(name: 'Bob Smith', email: 'bob@fake_email.com', password: 'mnbu23', password_confirmation: 'mnbu23')
    visit '/admin/login'
  end

  it 'shows login form' do
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_button("Login")
  end

  it 'happy path - it takes you to admin dashboard' do
    fill_in 'Email', with: 'tammy@fake_email.com'
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_link("Tammy Tanaka")
    expect(page).to have_link("Bob Smith")
  end

  it 'sad path 1 - it takes you to admin dashboard' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(admin_login_user_path)

    expect(page).to have_content('Please enter valid email')
  end

  it 'sad path 2 - it takes you to admin dashboard' do
    fill_in 'Email', with: 'tammy@fake_email.com'
    fill_in 'Password', with: ''
    click_button('Login')

    expect(current_path).to eq(admin_login_user_path)

    expect(page).to have_content('Please enter valid email or password')
  end

  it 'sad path 3 - it takes you to admin dashboard' do
    fill_in 'Email', with: 'dingdong@fake_email.com'
    fill_in 'Password', with: 'Abc123'
    click_button('Login')

    expect(current_path).to eq(admin_login_user_path)

    expect(page).to have_content('Please enter valid email or password')
  end
end
