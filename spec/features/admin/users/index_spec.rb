require 'rails_helper'

RSpec.describe 'Admin users page' do
  it 'has all registered user details' do
    user = User.create!(name: 'Tammy Tanaka', email: 'tammy@fake_email.com', password: 'Abc123', password_confirmation: 'Abc123')
    user2 = User.create!(name: 'Bob Smith', email: 'bob@fake_email.com', password: 'mnbu23', password_confirmation: 'mnbu23')

    visit admin_user_login_path
    fill_in :email, with: 'tammy@fake_email.com'
    fill_in :password, with: 'Abc123'
    click_button 'Login'

    expect(page).to have_content('All Users')
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user2.name)
    expect(page).to have_content(user2.email)
  end
end
